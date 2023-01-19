//
//  AlbumsApp.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import SwiftUI

@main
struct AlbumsApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = AlbumViewModel(
                albumClient: AlbumClient.shared,
                imageClient: ImageClient.shared
            )
            AlbumView(viewModel: viewModel)
        }
    }
}
