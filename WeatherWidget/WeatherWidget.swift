//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Hiep on 20/04/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let data = DataServices();
    
    func placeholder(in context: Context) -> SimpleEntry {
        
        print("hello \(data.getWeather().name)");
        print("hello1 \(data.hello())");
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

    var body: some View {
        ZStack {
            Image("bgsun")
//                .resizable()
                .aspectRatio(contentMode: .fit)
//                .edgesIgnoringSafeArea( .all)
            
            VStack {
                Text(entry.weather.main.feels_like.roundDouble() + "°")
                    .bold()
                    .font(.title)
                .foregroundStyle(.white)
                
                Text(entry.weather.name )
                    .bold()
                    .font(.title2)
                    .foregroundStyle(.white)
            }
        }
//        .edgesIgnoringSafeArea( .all)
        
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                WeatherWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
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
