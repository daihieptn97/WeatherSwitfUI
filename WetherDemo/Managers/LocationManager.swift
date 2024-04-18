//
//  LocationManager.swift
//  WetherDemo
//
//  Created by Hiệp Trần on 18/4/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    
    @Published var location : CLLocationCoordinate2D?
    @Published var isLoading = false;
    
//    init(location: CLLocationCoordinate2D? = nil, isLoading: Bool = false) {
//        self.location = location
//        self.isLoading = isLoading
//    }
//
    override init() {
        super.init()
        manager.delegate = self;
    }
    
    func requestLication() -> Void {
        isLoading  = true;
        manager.requestLocation();
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate;
        isLoading = false;
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error get location \(error)");
        isLoading = false;
    }
    
}
