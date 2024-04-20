//
//  WeatherView.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import SwiftUI
import BottomSheetSwiftUI

import MapKit

struct WeatherView: View {
    
    var weather : ResponseBodyWeatherData
    @State var bottomSheetPosition: BottomSheetPosition = .absolute(200)
    @State var isShowSheet = true;
    @State var isPresented = true;
    
    
    
    
    var body: some View {
        ZStack (alignment: .leading){
            VStack {
                VStack(alignment: .leading, spacing:  5) {
                    Text(weather.name)
                        .bold()
                        .font(.title)
                    Text("Today \(Date().formatted(.dateTime.month().day().hour().minute()))")
                        .fontWeight(.light)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing : 20){
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipShape(.circle)
                            } placeholder: {
                                LoaddingView()
                            }
                            .frame(width: 75, height: 75)
                            Text(weather.weather[0].description.caplockTheFirstText())
                        }
                        .frame(width: 150, alignment: .leading)
                        Spacer()
                        
                        Text(weather.main.feels_like.roundDouble() + "°")
                            .font(.system(size: 100))
                            .bold()
                    }
                    
                    Spacer().frame(height: 80)
                    
                    AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
                        
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350)
                    } placeholder: {
                        LoaddingView();
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            
            
            VStack{
                Spacer()
                
                
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.631, saturation: 0.773, brightness: 0.491))
        .preferredColorScheme(.dark)
        .foregroundColor(.white)
        //        .partialSheet(isPresented: $isPresented) {
        //                Text("Content of the Sheet")
        //             }
        .sheet(isPresented: $isShowSheet) {
            BottomSheetCustomView(weather: weather)
                .presentationDetents([.height(150), .medium, .large])
                .presentationDragIndicator(.visible)
                .interactiveDismissDisabled()
            
        }
        
    }
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}


struct BottomSheetCustomView : View {
    
    var weather: ResponseBodyWeatherData
    
    
    @State var annotations: [City] = []
    @State var coor =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 21.59076, longitude: 105.80152),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
    )
    
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                Text("Weather now".uppercased())
                    .bold()
                    .padding(.bottom)
                    .font(.title2)
                
                
                HStack {
                    WeatherRow(logo: "thermometer", name: "Thấp nhất", value: (weather.main.temp_min.roundDouble()) + "°")
                    Spacer()
                    WeatherRow(logo: "thermometer.transmission", name: "Cao nhất", value: (weather.main.temp_max.roundDouble()) + "°")
                }
                
                HStack {
                    WeatherRow(logo: "wind", name: "Gió", value: (weather.wind.speed?.roundDouble() ?? "0") + "ms/s")
                    Spacer()
                    WeatherRow(logo: "humidity", name: "Độ ẩm", value: (weather.main.humidity.roundDouble() + "%"))
                }
                
                HStack {
                    WeatherRow(logo: "sunrise", name: "Mặt trời mọc", value: weather.sys.sunrise.convertTimeStamps())
                    Spacer()
                    WeatherRow(logo: "sunset", name: "Mặt trời lặn", value: weather.sys.sunset.convertTimeStamps())
                }
                
                VStack {
                    Map(coordinateRegion: $region,
                               annotationItems: annotations)
                           { place in
                               MapMarker(coordinate: place.coordinate,
                                      tint: Color.purple )
                           }
                          
                           .frame(width: .infinity, height: 300)
                           .cornerRadius(14, corners: [.allCorners])
                           .preferredColorScheme(.light)
                }
                .padding(.top, 14)
              
                
           
        
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.leading, .trailing], 14)
            .padding([ .top], 24)
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .background(.white)
            
            .onAppear{
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude:  weather.coord.lat, longitude:  weather.coord.lon),
                    span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002)
                )
                
                annotations = [
                    City(name: "You", coordinate: CLLocationCoordinate2D(latitude:  weather.coord.lat, longitude:  weather.coord.lon)),
                ]
                coor =  MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: weather.coord.lat, longitude: weather.coord.lon), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005));
            }
        }
        
        
    }
}

#Preview {
    WeatherView(weather: previewWeather)
}
