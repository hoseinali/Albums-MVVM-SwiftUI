//
//  AlbumRowView.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import SwiftUI

struct AlbumRowView: View {
    @ObservedObject var viewModel: AlbumRowViewModel
    @State private var viewWidth: CGFloat = 0
    
    
    init(viewModel: AlbumRowViewModel) {
        self.viewModel = viewModel
        UITableViewCell.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color.clear.preference(key: ScreenWidthKey.self, value: proxy.size.width)
            }
            NavigationLink(destination: viewModel.mediaView) {
                HStack {
                    if self.viewModel.shouldShowError {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .frame(width: viewWidth/2, height: viewWidth/2)
                            .foregroundColor(.primary)
                    } else if viewModel.isLoading {
                        ProgressView()
                            .frame(width: viewWidth, height: viewWidth)
                    } else {
                        VStack {
                            viewModel.image
                                .resizable()
                                .cornerRadius(Constants.CGFloats.cornerRadiusRowImage)
                                .overlay(
                                    RoundedRectangle(cornerRadius: Constants.CGFloats.cornerRadiusRowImage)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                        }
                        .overlay(alignment: .bottom) {
                            Text("\(viewModel.size)").font(.system(size: 10))
                                .foregroundColor(.white)
                                .background(.gray.opacity(0.5))
                            
                        }
                        .frame(width: viewWidth, height: viewWidth)
                    }
                }
            }.isDetailLink(false)

        }
        .onPreferenceChange(ScreenWidthKey.self) { width in
            viewWidth = width - 4.0
        }
        .onAppear {
            self.viewModel.downloadImage(w: Int(viewWidth), h: Int(viewWidth), resizeMode: .crop)
        }
    }
}

struct ScreenWidthKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct ScreenHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct AlbumsRowView_Previews: PreviewProvider {
    static var previews: some View {
        
        // This is mock data for test
        let media = Media.init(id: "test", user_id: "test", media_type: "image", filename: "tanjir-ahmed-chowdhury-FCfu2MtA4Pw-unsplash.jpg", size: 983178, created_at: "2021-06-18T10:07:25Z", taken_at: nil, guessed_taken_at: nil, md5sum: "c05b80be8e13edbfac2ae089e4b4588a", content_type: "image/jpeg", video: nil, thumbnail_url: "https://imgdc1.kiliaro.com/shared/djlCbGusTJamg_ca4axEVw/imageresize/i/60cc705d0025904750ee22d300020eb4/0.jpg", download_url: "https://imgdc1.kiliaro.com/shared/djlCbGusTJamg_ca4axEVw/images/60cc705d0025904750ee22d300020eb4/download/tanjir-ahmed-chowdhury-FCfu2MtA4Pw-unsplash.jpg", resx: 3456, resy: 5184)
        
        
        let viewModel = AlbumRowViewModel(
            media: media,
            imageClient: ImageClient.shared
        )
        
        return AlbumRowView(viewModel: viewModel)
    }
}
