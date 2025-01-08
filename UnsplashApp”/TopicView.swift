//
//  TopicView.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import SwiftUI

struct TopicView: View {
    let topic: UnsplashTopic
    
    @StateObject var feedState = FeedState()
    @State private var selectedPhoto: UnsplashPhoto? = nil
    
    var body: some View{
        NavigationView {
            VStack {
                Button(action: {
                    Task {
                        await feedState.fetchTopicPhoto(topic_slug: topic.slug)
                    }
                }, label: {
                    Text("Load Data")
                })
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 150), spacing: 8),
                        GridItem(.flexible(minimum: 150), spacing: 8)
                    ], spacing: 8) {
                        if let topicPhoto = feedState.topicPhoto {
                            ForEach(topicPhoto, id: \.self) { photo in
                                NavigationLink(value: photo){
                                    AsyncImage(url: URL(string: photo.urls.regular)) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(12)
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(12)
                                                .clipped()
                                        case .failure:
                                            Image(systemName: "exclamationmark.triangle")
                                                .foregroundColor(.red)
                                                .frame(width: 150, height: 150)
                                                .cornerRadius(12)
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                            }
                        } else {
                            ForEach(0..<12) { _ in
                                Rectangle()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(12)
                                    .redacted(reason: .placeholder)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .navigationTitle(topic.slug.capitalized)
            }
            .navigationDestination(for: UnsplashPhoto.self) { photo in
                PhotoView(photo: photo)
            }
        }
    }
}
