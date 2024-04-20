//
//  ResponseBody.swift
//  WetherDemo
//
//  Created by Hiep on 20/04/2024.
//

import Foundation


struct ResponseBodyWeatherData: Codable {
    
    
    var coord : coordObj
    var weather : [weatherDecodable]
    var base :String
    var main :mainDecodable
    var visibility :Int
    var wind :windDecodable
    //    var rain :windDecodable
    var clouds :windDecodable?
    var dt :Double
    var timezone :Double
    var id :Double
    var cod :Double
    var name :String
    var sys :sysDecodable
    
    struct sysDecodable : Codable {
        
        
        var type: Int?
        var id: Double?
        var country: String
        var sunrise: Double
        var sunset: Double
        
    }
    
    struct cloudsDecodable: Codable {
        var all: Int
    }
    
    struct windDecodable: Codable {
        var speed: Double?
        var deg: Int?
        var gust: Double?
    }
    
    struct mainDecodable : Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Double
        var sea_level: Int
        var grnd_level: Int
        
        
    }
    
    struct weatherDecodable : Codable {
        var id : Int
        var main : String
        var description : String
        var icon : String
    }
    
    struct coordObj : Codable {
        var lon : Double
        var lat : Double
    }
}
