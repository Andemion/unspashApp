//
//  PhotoView.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation
import SwiftUI

struct PhotoView: View {
    let photo: UnsplashPhoto
    
    @State private var selectedSize: String = "Regular"
    @State private var photoURL: String
    
    init(photo: UnsplashPhoto) {
        self.photo = photo
        _photoURL = State(initialValue: photo.urls.regular)
    }
    
    var body: some View{
            VStack{
                HStack{
                    let user = photo.user
                    NavigationLink(value: user){
                        Text("Photo from @" + user.name)
                    }
                    AsyncImage(url: URL(string: user.profile_image.medium)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                        case .success(let image):
                            image
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                                .clipped()
                        case .failure:
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundColor(.red)
                                .frame(width: 50, height: 50)
                                .cornerRadius(12)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                }
                
                Picker("Size", selection: $selectedSize) {
                    Text("Regular").tag("Regular")
                    Text("Full").tag("Full")
                    Text("Small").tag("Small")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: selectedSize) { newValue in
                    switch newValue {
                    case "Full":
                        photoURL = photo.urls.full
                    case "Small":
                        photoURL = photo.urls.small
                    default:
                        photoURL = photo.urls.regular
                    }
                }
                
                ScrollView {
                    ScrollView(.horizontal) {
                        AsyncImage(url: URL(string: photoURL)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .cornerRadius(12)
                            case .success(let image):
                                image
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .cornerRadius(12)
                                    .clipped()
                            case .failure:
                                Image(systemName: "exclamationmark.triangle")
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .cornerRadius(12)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
        }
    }
}
