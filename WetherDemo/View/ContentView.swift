//
//  ContentView.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 17/04/2024.
//

import SwiftUI
import WidgetKit

var GROUP_NAME = "group.com.hieptn.weatherwidget";

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager();
    var weatherManager = WeatherManager()
    @State var weather: ResponseBodyWeatherData?
    
    @AppStorage("weatherJSon", store: UserDefaults(suiteName: GROUP_NAME)) var weatherJSon = ""
    

    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather  {
                    WeatherView(weather: weather);
                }else {
                    LoaddingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
                            let json =  try JSONEncoder().encode(weather);
                            weatherJSon = String(data: json, encoding: String.Encoding.utf8)!;
                            WidgetCenter.shared.reloadTimelines(ofKind: "WeatherWidget")
                        }catch {
                            print("Error getting the weather \(error)")
                        }
                    }
                }
                
                
            }else {
                if locationManager.isLoading {
                    LoaddingView()
                }else {
                    WellcomeUIView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.641, saturation: 0.864, brightness: 0.431, opacity: 0.881))
        .preferredColorScheme(.dark)
        
        
    }
    
}

#Preview {
    ContentView()
}
