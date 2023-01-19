//
//  AlbumViewModel.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//


import Combine
import Foundation
import UIKit
import SwiftUI

class MediaViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var shouldShowError = false
    
    let media: Media
    let imageClient: ImageClient
    @Published var image: Image = Image("DefaultImage")

    // A set to keep references to network requests.
    private var disposables = Set<AnyCancellable>()

    
    init(media: Media, imageClient: ImageClient) {
        self.media = media
        self.imageClient = imageClient
    }

    func downloadImage(w: Int,h: Int, resizeMode: ResizeMode) {
        isLoading = true
        guard let thumbnailURL = URL(string: media.thumbnail_url + "?h=\(h)&w=\(w)&m=\(resizeMode)") else {
            return
        }
        print(thumbnailURL)
        imageClient.download(fromURL: thumbnailURL)
            .sink(receiveCompletion: { downloadCompletion in
                switch downloadCompletion {
                case .finished:
                    self.isLoading = false
                case .failure:
                    self.shouldShowError = true
                }
            }, receiveValue: { image in
                self.image = Image(uiImage: image)
            })
            .store(in: &disposables)
    }
}
