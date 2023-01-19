//
//  NetworkingClient.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Foundation

class NetworkingClient {

    // MARK: - Constants

    let responseQueue: DispatchQueue?
    let session: DataTaskMaker

    // MARK: - Initializers

    init(
        session: DataTaskMaker,
        responseQueue: DispatchQueue?
    ) {

        self.responseQueue = responseQueue
        self.session = session
    }

}
