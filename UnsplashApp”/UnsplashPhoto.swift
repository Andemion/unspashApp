//
//  UnsplashPhoto.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 04/12/2024.
//

import Foundation
import SwiftUI

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let slug: String
    let author: User
    let url: UnsplashImageUrls
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
