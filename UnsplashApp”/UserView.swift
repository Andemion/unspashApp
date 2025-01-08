//
//  PhotoView.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 08/01/2025.
//

import Foundation
import SwiftUI

struct UserView: View {
    let user: UnsplashUser
    
    var body: some View{
            VStack{
                AsyncImage(url: URL(string: user.profile_image.large)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                    case .success(let image):
                        image
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                            .clipped()
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                            .frame(width: 200, height: 200)
                            .cornerRadius(12)
                    @unknown default:
                        EmptyView()
                    }
                }
                    
                Text("Profile @" + user.name)
                
                    Text("Statistics")
                    VStack{
                        Text("Collections : " + String(user.total_collections))
                        Text("Likes : " + String(user.total_likes))
                        Text("Nombre de photos : " + String(user.total_photos))
                    }
                
                
                    Text("links")
                    HStack{
                        Button(
                            action: {
                                Task {
                                    
                                }
                            },
                            label: {
                                Text("Photos")
                            }
                        )
                        Button(
                            action: {
                                Task {
                                    
                                }
                            },
                            label: {
                                Text("Likes")
                            }
                        )
                        Button(
                            action: {
                                Task {
                                    
                                }
                            },
                            label: {
                                Text("Portofolio")
                            }
                        )
                    }
                
            }
        }
}
