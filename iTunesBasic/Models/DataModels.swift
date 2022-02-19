//
// DataModels.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import Foundation

struct StorePost:Codable {
    let term:String?
    let country:String?
    let limit:Int?
}

struct StoreCheckResponse:Codable {
    let resultCount:Int?
    let results:[StoreResponse]?
}

struct StoreResponse:Codable {
    let wrapperType:String?
    let kind:String?
    let artistId:Int?
    let collectionId:Int?
    let trackId:Int?
    let artistName:String?
    let collectionName:String?
    let trackName:String?
    let artworkUrl100:String?
    let collectionPrice:Double?
    let releaseDate:String?
    let country:String?
    let currency:String?
    let longDescription:String?
}

struct Types {
    let name:String!
    var isSelected:Bool!
}
