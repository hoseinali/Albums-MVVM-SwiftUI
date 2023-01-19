//
//  AlbumBuilder.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import SwiftUI

// This entity will act as a factory to create screens that are
// needed when navigating from the AlbumRowView.
enum MediaBuilder {
  static func makeMediaView(
    withAlbum media: Media,
    imageClient: ImageClient
  ) -> some View {
    let viewModel = AlbumDisplayViewModel(
        media: media,
      imageClient: imageClient
    )
    return MediaView(viewModel: viewModel)
  }
}
