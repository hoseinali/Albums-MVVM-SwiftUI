//
//  AlbumsViewModel.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import Combine
import Foundation

class AlbumViewModel: ObservableObject {

    @Published var dataSource: [AlbumRowViewModel] = []
    @Published var isLoading: Bool = false

    let albumClient: AlbumClient
    let imageClient: ImageClient

    // A set to keep references to network requests.
    private var disposables = Set<AnyCancellable>()

    init(albumClient: AlbumClient, imageClient: ImageClient) {
        self.albumClient = albumClient
        self.imageClient = imageClient

        loadAlbums()
    }
}


 extension AlbumViewModel {
    func loadAlbums() {
        isLoading = true
        albumClient.getAlbum()
            .map { response in
                response.map { media -> AlbumRowViewModel in
                    AlbumRowViewModel(media: media, imageClient: self.imageClient)
                }
        }
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                self.isLoading = false
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] meidaRows in
                guard let self = self else { return }
                self.dataSource = meidaRows
        })
        .store(in: &disposables)
    }
}

