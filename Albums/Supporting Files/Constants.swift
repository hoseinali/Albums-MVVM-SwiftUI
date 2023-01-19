//
//  Constants.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//


import Foundation
import UIKit

enum Constants {

    enum URLs {
        static let baseURL = "https://api1.kiliaro.com"
        static let sharedID = "djlCbGusTJamg_ca4axEVw"
        static var SharedURL: URL? {
            let feed = "\(baseURL)/shared/\(sharedID)/media"
            return URL(string: feed)
        }
    }

    enum Colors {
        static let navigationBarbackgroundColor: UIColor = UIColor.systemBackground
        static let tableViewBackgroundColor: UIColor = UIColor.systemBackground
    }
    enum CGFloats {
        static let cornerRadiusRowImage: CGFloat = 8

    }
}
