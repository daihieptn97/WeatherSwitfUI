//
//  DataServices.swift
//  WeatherWidgetExtension
//
//  Created by Hiep on 20/04/2024.
//

import Foundation
import SwiftUI

struct DataServices {
    
    @AppStorage("weatherJSon", store: UserDefaults(suiteName: "group.com.hieptn.weatherwidget"))
    private var weatherJSon = "";
    
    
    func getWeather() -> ResponseBodyWeatherData {
        print("getWeather: \(weatherJSon)")
        do {
            let weather = try JSONDecoder().decode(ResponseBodyWeatherData.self, from: Data(weatherJSon.utf8));
            return weather;
        } catch {
            return previewWeather;
        }
        return previewWeather;
    }
    
    func hello() -> String {
        print("->\(weatherJSon)<-")
        
       
        return weatherJSon;
    }
    
}
