//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Hiep on 20/04/2024.
//

import WidgetKit
import SwiftUI
import URLImage

    
struct Provider: TimelineProvider {
    
    let data = DataServices();
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), weather: data.getWeather())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),  weather: data.getWeather())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,  weather: data.getWeather())
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weather: ResponseBodyWeatherData
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    var date = Date();

    var body: some View {
        VStack() {
            Text(entry.weather.name)
                .foregroundStyle(Color(red: 0.337, green: 0.527, blue: 0.875))
                .font(.system(size: 15))
                .bold()
                .onAppear{
                    print("https://openweathermap.org/img/wn/\(entry.weather.weather[0].icon).png")
                }
            VStack{
                Text(entry.weather.main.feels_like.roundDouble() + "°")
                    .foregroundStyle(Color(red: 0.337, green: 0.527, blue: 0.875))
                    .font(.system(size: 48))
                    .fontWeight(.thin)
                
                Text(String(date.dayOfWeek()!))
                    .foregroundStyle(Color(red: 0.623, green: 0.737, blue: 0.95))
                    .font(.system(size: 10))
            }
            Spacer()
            Text(entry.weather.weather[0].description.caplockTheFirstText())
                .font(.system(size: 12))
                .multilineTextAlignment(.center)
                .foregroundStyle(Color(red: 0.337, green: 0.527, blue: 0.875))
                .fontWeight(.thin)
            
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text( entry.weather.main.humidity.roundDouble() + "%")
                        .font(.system(size: 12))
                        .foregroundStyle(Color(red: 0.344, green: 0.531, blue: 0.875))
                   

                }
               
                Text( (entry.weather.wind.speed?.roundDouble() ?? "0") + "ms/s")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(red: 0.344, green: 0.531, blue: 0.875))
            }
//                .fontWeight(.thin)
            

                
            
//            VStack {
//                Text(entry.weather.main.feels_like.roundDouble() + "°")
//                    .bold()
//                    .font(.title)
////                .foregroundStyle(.white)
//                
//                Text(entry.weather.name )
//                    .bold()
//                    .font(.title2)
////                    .foregroundStyle(.white)
//            }
        }
//        .background(.white)
//        .edgesIgnoringSafeArea( .all)
        
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherWidgetEntryView(entry: entry)
                    .containerBackground(.white, for: .widget)
//                    .edgesIgnoringSafeArea(.all)
            } else {
                WeatherWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    WeatherWidget()
} timeline: {
    SimpleEntry(date: .now, weather: previewWeather)
//    SimpleEntry(date: .now, weather: previewWeather)
}
