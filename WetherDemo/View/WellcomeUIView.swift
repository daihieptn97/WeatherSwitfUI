//
//  WellcomeUIView.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import SwiftUI
import CoreLocationUI


struct WellcomeUIView: View {
    
    @EnvironmentObject var locationManager:LocationManager
    
    var body: some View {
        VStack {
            VStack( spacing: 20){
                Text("Wellcome to the weather app")
                    .bold().font(.title);
                
                Text("Please share your location to get the weather in your area")
                    .padding()
                
                
            }
            .multilineTextAlignment(.center)
            .padding()
            
            LocationButton(.shareCurrentLocation) {
                locationManager.requestLication();
            }
            .cornerRadius(30)
            .symbolVariant(.fill)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    WellcomeUIView()
}
