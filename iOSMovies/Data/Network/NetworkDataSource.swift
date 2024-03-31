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
        
        url.append(queryItems: getQueryParameters())
        
        print(url.absoluteString)

        let request = getURLRequest(url: url)
        
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
    
    func getMovieCredit(movieId: Int) async throws -> MovieCreditResponse {
        let endpointPopularMovies = "\(baseURL)movie/\(movieId)/credits"
        
        guard var url = URL(string: endpointPopularMovies) else {
            throw MovieServiceError.invalidURL
        }
        
        url.append(queryItems: getQueryParameters())
        
        print(url.absoluteString)

        let request = getURLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw MovieServiceError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let credit = try decoder.decode(MovieCreditResponse.self, from: data)
            return credit
        } catch {
            throw MovieServiceError.invalidJson
        }
    }
    
    private func getQueryParameters() -> [URLQueryItem] {
        return [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "pt-br"),
            //URLQueryItem(name: "language", value: "en-US"),
        ]
    }
    
    private func getURLRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = headers
        
        return urlRequest
    }
    
}
