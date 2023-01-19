//
//  AlbumView.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//


import SwiftUI

struct MediaView: View {
    @ObservedObject var viewModel: AlbumDisplayViewModel
    @State private var viewWidth: CGFloat = 0
    @State private var viewHeight: CGFloat = 0
    
    let buttonCornerRadius: CGFloat = 5.0
    
    init(viewModel: AlbumDisplayViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Color.clear.preference(key: ScreenWidthKey.self, value: proxy.size.width)
                Color.clear.preference(key: ScreenHeightKey.self, value: proxy.size.height)
            }
            VStack {
                if self.viewModel.shouldShowError {
                    Text("Something went wrong we are not able to load image")
                        .font(.body)
                        .padding()
                } else if self.viewModel.isLoading {
                    ProgressView("Loading...")
                } else {
                    self.viewModel.image
                        .resizable()
                    Text("\(self.viewModel.created_at)")
                        .font(.subheadline)
                        .padding(.bottom, 10)
                }
            }
            
            .navigationBarTitle("", displayMode: .inline)
        }
        .onPreferenceChange(ScreenWidthKey.self) { width in
            viewWidth = width
        }
        .onPreferenceChange(ScreenHeightKey.self) { height in
            viewHeight = height
        }
        .onAppear {
            self.viewModel.downloadImage(w: Int(viewWidth), h: Int(viewHeight), resizeMode: .bb)
        }
    }
}

struct MedaiView_Previews: PreviewProvider {
    static var previews: some View {
         // This is mock data for test
        
        let media = Media.init(id: "test", user_id: "test", media_type: "image", filename: "tanjir-ahmed-chowdhury-FCfu2MtA4Pw-unsplash.jpg", size: 983178, created_at: "2021-06-18T10:07:25Z", taken_at: nil, guessed_taken_at: nil, md5sum: "c05b80be8e13edbfac2ae089e4b4588a", content_type: "image/jpeg", video: nil, thumbnail_url: "https://imgdc1.kiliaro.com/shared/djlCbGusTJamg_ca4axEVw/imageresize/i/60cc705d0025904750ee22d300020eb4/0.jpg", download_url: "https://imgdc1.kiliaro.com/shared/djlCbGusTJamg_ca4axEVw/images/60cc705d0025904750ee22d300020eb4/download/tanjir-ahmed-chowdhury-FCfu2MtA4Pw-unsplash.jpg", resx: 3456, resy: 5184)
        
        
        let viewModel = AlbumDisplayViewModel(
            media: media,
            imageClient: ImageClient.shared
        )
        
        return MediaView(viewModel: viewModel)
    }
}
