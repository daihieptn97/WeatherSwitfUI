//
//  WeatherRow.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import SwiftUI

struct WeatherRow: View {
    
    var logo: String
    var name: String
    var value: String
    
    var body: some View {
        HStack(spacing: 20){
            Image(systemName: logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.058, brightness: 0.722, opacity: 0.606))
                .cornerRadius(50)
//                .background(.gray)
            
            VStack (alignment : .leading) {
                Text(name)
                    .font(.caption)
                Text(value)
                    .bold()
//                    .font(.system(size: 20))
                    .font(.title2)
            }
//            .background(.red)
            Spacer()
        }
        .frame(maxWidth: .infinity)
      
    }
}

#Preview {
    WeatherRow(logo: "sun.max.fill", name: "Feels", value: "8°")
}
