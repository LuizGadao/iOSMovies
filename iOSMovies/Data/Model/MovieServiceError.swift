//
//  MovieServiceError.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 13/03/24.
//

import Foundation

enum MovieServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidJson
}
