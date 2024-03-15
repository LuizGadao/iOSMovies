//
//  NetworkDataSource.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import Foundation

class NetworkdDataSource {
    
    private let apiKey = LocalProperties().getApiKey()
    private let baseURL = "https://api.themoviedb.org/3/"
    private var page = 0

    private lazy var headers = [
        "accept": "application/json"
    ]
    
    
    init() { }
    
    func getMovies() async throws -> MovieResponse {
        self.page = page + 1
        let endpointPopularMovies = "\(baseURL)movie/popular?page=\(self.page)"
        
        guard var url = URL(string: endpointPopularMovies) else {
            throw MovieServiceError.invalidURL
        }
        
        url.append(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: "pt-br"),
                //URLQueryItem(name: "language", value: "en-US"),
            ]
        )
        
        print(url.absoluteString)

        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
    
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MovieServiceError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let movieResponse = try decoder.decode(MovieResponse.self, from: data)
            return movieResponse
        } catch {
            throw MovieServiceError.invalidJson
        }
    }
    
}
