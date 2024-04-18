//
//  WeatherManager.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    var KEY = "48cb1bb771d5a8483f5652a11f3fc47c"
    
    func getCurrentWeather(lat: CLLocationDegrees, long: CLLocationDegrees) async throws -> ResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(KEY)&units=metric&lang=vi"  ) else  {fatalError("url is empty")}
        
        let urlRequest = URLRequest(url: url);
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest);
        
        guard (response as? HTTPURLResponse)?.statusCode ==  200  else { fatalError("Error fetching data") }
        
        
        let dataString = String(bytes: data, encoding: String.Encoding.utf8);
        print(dataString ?? "");
        
        let dataDecode =    try JSONDecoder().decode(ResponseBody.self, from: data);
        return dataDecode;
    }
}


struct ResponseBody: Decodable {
    
    
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
    
    struct sysDecodable : Decodable {
        
        
        var type: Int
        var id: Double
        var country: String
        var sunrise: Double
        var sunset: Double
        
    }
    
    struct cloudsDecodable: Decodable {
        var all: Int
    }
    
    struct windDecodable: Decodable {
        var speed: Double?
        var deg: Int?
        var gust: Double?
    }
    
    struct mainDecodable : Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Double
        var sea_level: Int
        var grnd_level: Int
        
        
    }
    
    struct weatherDecodable : Decodable {
        var id : Int
        var main : String
        var description : String
        var icon : String
    }
    
    struct coordObj : Decodable {
        var lon : Double
        var lat : Double
    }
}
