//
//  AlbumDisplayViewModel.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Foundation
import UIKit

class AlbumDisplayViewModel: MediaViewModel {
    var created_at: String {
        return formattedDate(from: media.created_at)
    }
}

private extension AlbumDisplayViewModel {

    // Format the release date presentation
    func formattedDate(from releaseDate: String) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.locale = .current

        if let date = formatter.date(from: releaseDate) {
            formatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMM d YYYY", options: 0, locale: .current)
            return formatter.string(from: date)
        } else {
            return releaseDate
        }
    }
}
