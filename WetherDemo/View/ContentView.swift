//
//  ContentView.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 17/04/2024.
//

import SwiftUI
import PartialSheet

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager();
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    
    
    var body: some View {
        VStack {
            
            if let location = locationManager.location {
//                Text("Your location are: \(location.latitude), \(location.longitude)");
                
                if let weather = weather  {
                    WeatherView(weather: weather);
                }else {
                    LoaddingView().task {
                        do {
                            weather = try await weatherManager.getCurrentWeather(lat: location.latitude, long: location.longitude)
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
        .attachPartialSheetToRoot()
        
    }
        
}

#Preview {
    ContentView()
}
