//
//  MovieCredit.swift
//  iOSMovies
//
//  Created by Luiz Carlos Goncalves Dos Anjos on 19/03/24.
//

import Foundation


struct MovieCreditResponse: Codable {
    let id: Int
    let cast: [Person]
    let crew: [Person]
}

struct Person: Codable {
    let adult: Bool
    let gender: Int
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int?
    let character: String?
    let creditId: String
    let order: Int?
    let department: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order, department, job
    }
}
