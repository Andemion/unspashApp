//
//  UnplashTopic.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation

import Foundation
import SwiftUI

struct UnsplashTopic: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let user: User
    let urls: UnsplashImageUrls
    
    // Implémentation des méthodes requises par Hashable
    static func == (lhs: UnsplashPhoto, rhs: UnsplashPhoto) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct User: Codable {
    let name: String
}

struct UnsplashImageUrls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
