//
//  LocationManager.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/24/23.
//

import CoreLocation
import Foundation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var locationData: CLLocation?
    @Published var loading = true
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func getLat() -> String {
        return "\(locationData?.coordinate.latitude ?? 0)"
    }
    
    func getLon() -> String {
        return "\(locationData?.coordinate.longitude ?? 0)"
    }
    
    func requestLocation() async {
        loading = true
        locationManager.requestWhenInUseAuthorization()
    }
    
    func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationData = location
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: failed location manager access")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
        
        switch locationStatus {
            case .authorizedAlways:
                locationManager.startUpdatingLocation()
                loading = false
                print("Status changed: authorized always")
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
                loading = false
                print("Status changed: authorized when in use")
            case .denied:
                print("Status changed: denied")
            case .notDetermined:
                print("Status changed: not determined")
            case .restricted:
                print("Status changed: restricted")
            default:
                break
        }
    }
}
