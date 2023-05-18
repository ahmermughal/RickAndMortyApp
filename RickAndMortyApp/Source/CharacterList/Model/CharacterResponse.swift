//
//  CharacterResponse.swift
//  RickAndMortyApp
//
//  Created by Ahmer Akhter on 18/05/2023.
//

import Foundation


struct CharacterResponse : Codable{
    let info : CharacterPageInfo
    let results : [CharacterProfile]
}

struct CharacterPageInfo : Codable{
    let count: Int
    let pages: Int
    let nextPage: String?
    let prevPage: String?
    
    
    enum CodingKeys: String, CodingKey{
        case count
        case pages
        case nextPage = "next"
        case prevPage = "prev"
    }
}

struct CharacterProfile : Codable {
    let name : String
    let species : String
    let status: String
    let imageURL : String
    
    enum CodingKeys: String, CodingKey{
        case name
        case species
        case status
        case imageURL = "image"
    }
    
}
