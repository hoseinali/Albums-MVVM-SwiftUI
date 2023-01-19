//
//  DataTaskMaker.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Foundation

protocol DataTaskMaker {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: DataTaskMaker { }
