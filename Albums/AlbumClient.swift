//
//  AlbumClient.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Combine
import Foundation

class AlbumClient: NetworkingClient {

    // MARK: - Constants

    private let albumURL: URL?

    static let shared =
    AlbumClient(
        albumURL: Constants.URLs.SharedURL,
            session: URLSession.shared,
            responseQueue: .main
    )

    // MARK: - Initializers

    init(
        albumURL: URL?,
        session: DataTaskMaker,
        responseQueue: DispatchQueue?
    ) {
        self.albumURL = albumURL

        super.init(session: session, responseQueue: responseQueue)
    }

    // MARK: - Functions

    func getAlbum() -> AnyPublisher<Medias, NetworkingError> {

        guard let albumURL = albumURL else {
            let error = NetworkingError.invalidURL
            return Fail(error: error).eraseToAnyPublisher()
        }

        guard let responseQueue = responseQueue else {
            let error = NetworkingError.invalidResponseQueue
            return Fail(error: error).eraseToAnyPublisher()
        }

        let urlRequest = URLRequest(url: albumURL)
        print(urlRequest)
        return session.dataTaskPublisher(for: urlRequest)
    
            .receive(on: responseQueue)
            .tryMap { dataTaskOutput in
                guard
                    let httpURLResponse = dataTaskOutput.response as? HTTPURLResponse,
                    httpURLResponse.statusCode == 200
                    else {
                        throw NetworkingError.statusCode
                }
                return dataTaskOutput.data
        }
        .decode(type: Medias.self, decoder: JSONDecoder())
        .mapError { NetworkingError.map($0) }
        .eraseToAnyPublisher()
    }

}
