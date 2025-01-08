//
//  FeedState.swift
//  UnsplashApp”
//
//  Created by ROUSSEL Arnaud on 07/01/2025.
//

import Foundation

class FeedState: ObservableObject{
    
    @Published var homeFeed: [UnsplashPhoto]?
    @Published var topics: [UnsplashTopic]?
    @Published var topicPhoto: [UnsplashPhoto]?
    
    var api = UnsplashAPI()
    
    let apiKey : String = ConfigurationManager.instance.plistDictionnary.clientId

    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    func fetchHomeFeed() async {
        // Créez une URL avec la clé d'API
        let url = api.feedUrl()!

        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)

            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)

            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)

            // Mettez à jour l'état de la vue sur le thread principal
            DispatchQueue.main.async {
                self.homeFeed = deserializedData
            }

        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchHomeTopic() async {
        // Créez une URL avec la clé d'API
        let url = api.topicUrl()!

        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)

            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)

            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashTopic].self, from: data)

            // Mettez à jour l'état de la vue sur le thread principal
            DispatchQueue.main.async {
                self.topics = deserializedData
            }

        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchTopicPhoto(topic_slug :String) async {
        // Créez une URL avec la clé d'API
        let url = api.topicPhotosUrl(topic_slug: topic_slug)!
        do {
            // Créez une requête avec cette URL
            let request = URLRequest(url: url)

            // Faites l'appel réseau
            let (data, _) = try await URLSession.shared.data(for: request)

            // Transformez les données en JSON
            let deserializedData = try JSONDecoder().decode([UnsplashPhoto].self, from: data)

            // Mettez à jour l'état de la vue sur le thread principal
            DispatchQueue.main.async {
                self.topicPhoto = deserializedData
            }

        } catch {
            print("Error: \(error)")
        }
    }
}
