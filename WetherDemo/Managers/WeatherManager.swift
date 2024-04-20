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
    
    func getCurrentWeather(lat: CLLocationDegrees, long: CLLocationDegrees) async throws -> ResponseBodyWeatherData {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(KEY)&units=metric&lang=vi"  ) else  {fatalError("url is empty")}
        
        let urlRequest = URLRequest(url: url);
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest);
        
        guard (response as? HTTPURLResponse)?.statusCode ==  200  else { fatalError("Error fetching data") }
        
        
        let dataString = String(bytes: data, encoding: String.Encoding.utf8);
        print(dataString ?? "");
        
        let dataDecode =    try JSONDecoder().decode(ResponseBodyWeatherData.self, from: data);
        return dataDecode;
    }
}

