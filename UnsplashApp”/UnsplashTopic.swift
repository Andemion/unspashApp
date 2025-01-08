//
//  UnsplashTopic.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation

import SwiftUI

struct UnsplashTopic: Codable, Identifiable, Hashable {
    let id: String
    let slug: String
    let links: UnsplashTopicLinks
    let cover_photo: UnsplashPhoto
    
    // Implémentation des méthodes requises par Hashable
    static func == (lhs: UnsplashTopic, rhs: UnsplashTopic) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct UnsplashTopicLinks: Codable {
    let `self`: String
    let html: String
    let photos: String
}
