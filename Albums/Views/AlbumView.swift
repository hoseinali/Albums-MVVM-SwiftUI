//
//  AlbumsView.swift
//  Albums
//
//  Created by hossein on 10/23/1401 AP.
//

import SwiftUI

struct AlbumView: View {
    
    @ObservedObject var viewModel: AlbumViewModel
    @State var showClearCacheAlert = false
    private let columns = [GridItem(), GridItem(), GridItem()]
    
    init(viewModel: AlbumViewModel) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = Constants.Colors.navigationBarbackgroundColor
    }
    
    var body: some View {
        NavigationView {
          if viewModel.isLoading {
                ProgressView("Loading...")
            } else {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        if viewModel.dataSource.isEmpty {
                            emptySection
                        } else {
                            albumRows
                        }
                    }
                }
                .padding(.horizontal)
                .navigationBarTitle("Test Album", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showClearCacheAlert = true
                            print("Clear cache")
                        } label: {
                            Image(systemName: "exclamationmark.icloud.fill")
                                .foregroundColor(.primary)
                        }
                        .alert(isPresented:$showClearCacheAlert) {
                            Alert(
                                title: Text("Are you sure you want to download all images again? (Cash memory is removed)"),
                                primaryButton: .destructive(Text("Delete")) {
                                    URLCache.shared.removeAllCachedResponses()
                                    viewModel.loadAlbums()
                                },
                                secondaryButton: .cancel()
                            )
                        }

                    }
                }
            }
        }
        
    }
}

private extension AlbumView {
    var emptySection: some View {
        Text("No results")
            .foregroundColor(.gray)
    }
    
    var albumRows: some View {
        ForEach(viewModel.dataSource, content: AlbumRowView.init(viewModel:))
    }
}

struct AlbumView_Previews: PreviewProvider {
    static var previews: some View {
        Text("No current preview")
    }
}
