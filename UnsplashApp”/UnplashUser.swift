//
//  UnplashUser.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 08/01/2025.
//

import Foundation
import SwiftUI

struct UnsplashUser: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let profile_image: UnsplashProfilImageUrls
    let links: UnsplashProfilLinks
    let total_collections: Int
    let total_likes: Int
    let total_photos: Int
    
    // Implémentation des méthodes requises par Hashable
    static func == (lhs: UnsplashUser, rhs: UnsplashUser) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UnsplashProfilImageUrls: Codable {
    let small: String
    let medium: String
    let large: String
}

struct UnsplashProfilLinks: Codable {
    let photos: String
    let likes: String
    let portfolio: String
}
