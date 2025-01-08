//
//  UnsplashAPI.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation
 
struct UnsplashAPI {
    
    private let scheme = "https"
    private let host = "api.unsplash.com"
    private let apiKey =  ConfigurationManager.instance.plistDictionnary.clientId
 
    func unsplashApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.queryItems = [
            URLQueryItem(name: "client_id", value: apiKey)
        ]
        return components
    }
 
    func feedUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/photos"
        components.queryItems?.append(contentsOf: [
                URLQueryItem(name: "order_by", value: orderBy),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        )
        return components.url
    }
    
    func topicUrl(orderBy: String = "popular", perPage: Int = 10) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/topics"
        components.queryItems?.append(contentsOf: [
                URLQueryItem(name: "order_by", value: orderBy),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        )
        return components.url
    }
    
    func topicPhotosUrl(topic_slug: String, orderBy: String = "popular", perPage: Int = 50) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/topics/" + topic_slug + "/photos"
        components.queryItems?.append(contentsOf: [
                URLQueryItem(name: "order_by", value: orderBy),
                URLQueryItem(name: "per_page", value: String(perPage))
            ]
        )
        return components.url
    }
    
    func userProfilUrl(username: String) -> URL? {
        var components = unsplashApiBaseUrl()
        components.path = "/users/" + username
        return components.url
    }
}
