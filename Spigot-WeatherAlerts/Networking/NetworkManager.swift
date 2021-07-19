//
//  NetworkManager.swift
//  Spigot-WeatherAlerts
//
//  Created by Birch, Nathan J on 7/15/21.
//

import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
               
    private let weatherURL = "https://api.alltheapps.org/weather/v3/allActiveAlerts?apiKey=FRITZ_TEMP"
    
    var downloadedImages = [IndexPath: UIImage]()
        
    private init() {}
    
    func getWeatherAlerts(completed: @escaping (Result<[WeatherAlert], WAError>) -> Void ) {
        guard let url = URL(string: weatherURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(WeatherResponse.self, from: data)
                completed(.success(decodedResponse.alerts))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}

