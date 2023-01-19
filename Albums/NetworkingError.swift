//
//  NetworkingError.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Foundation

enum NetworkingError: Error {
    case statusCode
    case invalidImage
    case invalidURL
    case invalidResponseQueue
    case other(Error)

    static func map(_ error: Error) -> NetworkingError {
        return (error as? NetworkingError) ?? .other(error)
    }
}
