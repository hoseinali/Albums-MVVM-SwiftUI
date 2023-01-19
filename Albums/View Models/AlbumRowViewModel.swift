//
//  AlbumRowViewModel.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import SwiftUI

// Needs to conform to Identifiable in order to user ForEach in AlbumsView
class AlbumRowViewModel: MediaViewModel, Identifiable {
    var id: String {
        return media.id
    }
    var size: String {
        return ByteCountFormatter.string(fromByteCount: media.size, countStyle: .file)
    }
}

extension AlbumRowViewModel {
  var mediaView: some View {
    return MediaBuilder.makeMediaView(
      withAlbum: media,
      imageClient: imageClient
    )
  }
}
