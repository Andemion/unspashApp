//
//  UnsplashPhoto.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 04/12/2024.
//

import Foundation
import SwiftUI

struct UnsplashPhoto: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let user: UnsplashUser
    let urls: UnsplashImageUrls
    
    // Implémentation des méthodes requises par Hashable
    static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UnsplashImageUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}


