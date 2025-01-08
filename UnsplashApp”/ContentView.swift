import SwiftUI

struct ContentView: View {
    
    @StateObject var feedState = FeedState()
    @State private var selectedTopic: UnsplashTopic? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                Button(action: {
                    Task {
                        await feedState.fetchHomeTopic()
                        await feedState.fetchHomeFeed()
                    }
                },
                       label: {
                    Text("Load Data")
                }
                )
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        if let topics = feedState.topics {
                            ForEach(topics, id: \.self) { topic in
                                NavigationLink(value: topic) {
                                    VStack(spacing: 2) {
                                        AsyncImage(url: URL(string: topic.cover_photo.urls.small)) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 50)
                                                    .cornerRadius(12)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFill()
                                                    .frame(width: 100, height: 50)
                                                    .cornerRadius(12)
                                                    .clipped()
                                            case .failure:
                                                Image(systemName: "exclamationmark.triangle")
                                                    .foregroundColor(.red)
                                                    .frame(width: 100, height: 50)
                                                    .cornerRadius(12)
                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                        Text(topic.slug)
                                    }
                                }
                            }
                        } else {
                            ForEach(0..<10) { _ in
                                VStack(spacing: 2) {
                                    Rectangle()
                                        .frame(width: 100, height: 50)
                                        .cornerRadius(12)
                                        .redacted(reason: .placeholder)
                                        .foregroundColor(.gray)
                                    Rectangle()
                                        .frame(width: 80, height: 10)
                                        .cornerRadius(12)
                                        .redacted(reason: .placeholder)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible(minimum: 150), spacing: 8),
                        GridItem(.flexible(minimum: 150), spacing: 8)
                    ], spacing: 8) {
                        if let homeFeed = feedState.homeFeed {
                            ForEach(homeFeed, id: \.self) { photo in
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
                
            }
            .navigationDestination(for: UnsplashTopic.self) { topic in
                    TopicView(topic: topic)
                }
            .navigationDestination(for: UnsplashPhoto.self) { photo in
                    PhotoView(photo: photo)
                }
            .navigationDestination(for: UnsplashUser.self) { user in
                    UserView(user: user)
                }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .navigationTitle("Feed")
        }
    }
}
