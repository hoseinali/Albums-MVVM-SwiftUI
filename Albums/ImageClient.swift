//
//  ImageClient.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Combine
import Foundation
import UIKit

class ImageClient: NetworkingClient {

    // MARK: - Constants

    static let shared =
        ImageClient(
            session: URLSession.shared,
            responseQueue: .main
    )

    // MARK: - Functions

    func download(fromURL url: URL) -> AnyPublisher<UIImage, NetworkingError> {
         guard let responseQueue = responseQueue else {
             let error = NetworkingError.invalidResponseQueue
             return Fail(error: error).eraseToAnyPublisher()
         }

         let urlRequest = URLRequest(url: url)

         return session.dataTaskPublisher(for: urlRequest)

             .receive(on: responseQueue)

             // Can't infer output type of Data due to pipeline of operators using tryMap.
             .tryMap { response -> Data in
                 guard
                     let httpURLResponse = response.response as? HTTPURLResponse,
                     httpURLResponse.statusCode == 200
                     else {
                         throw NetworkingError.statusCode
                 }

                 return response.data
         }

             // Convert Data to UIImage
             .tryMap { data in
                 guard let image = UIImage(data: data) else {
                     throw NetworkingError.invalidImage
                 }
                 return image
         }

         .mapError { NetworkingError.map($0) }
         .eraseToAnyPublisher()
     }
}
