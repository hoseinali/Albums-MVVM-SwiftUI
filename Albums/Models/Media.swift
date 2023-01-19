//
//  Album.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Foundation

struct Media: Codable {

    let id: String
    let user_id: String
    let media_type: String
    let filename: String
    let size: Int64
    let created_at: String
    let taken_at: String?
    let guessed_taken_at: String?
    let md5sum: String
    let content_type: String
    let video: String?
    let thumbnail_url: String
    let download_url: String
    let resx: Int
    let resy: Int

}
typealias Medias = [Media]
