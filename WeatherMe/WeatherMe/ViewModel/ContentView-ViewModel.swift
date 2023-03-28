//
//  ContentView-ViewModel.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/21/23.
//

import CoreLocation
import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var forecast = Forecast()
        @Published var showAlert = false
        
        var apiKey: String = ""
        
        init() {
            apiKey = ProcessInfo.processInfo.environment["API_KEY"] ?? ""
            print(apiKey)
        }
        
        func checkApiStatus() {
            if apiKey == "INSERT_YOUR_KEY" {
                showAlert = true
            } else {
                showAlert = false            }
        }
        
        public func translateWeatherCode(descCode: String) -> String {
            var weatherPNG = ""
            
            switch descCode {
            case "Clear":
                weatherPNG = "sun.and.horizon.fill"
            case "Clouds":
                weatherPNG = "cloud.sun.fill"
            case "shower rain":
                weatherPNG = "cloud.rain.fill"
            case "Rain":
                weatherPNG = "cloud.heavyrain.fill"
            case "Drizzle":
                weatherPNG = "cloud.drizzle.fill"
            case "Thunderstorm":
                weatherPNG = "cloud.bolt.fill"
            case "Snow":
                weatherPNG = "cloud.snow.fill"
            case "Mist":
                weatherPNG = "wind.circle.fill"
            case "Smoke":
                weatherPNG = "smoke.fill"
            case "Fog":
                weatherPNG = "cloud.fog.fill"
            default:
                weatherPNG = "cloud.fill"
            }
            
            return weatherPNG
        }
        
        //Converting hPa to inHg
        public func convertPressure(hpaNum: Int) -> Int {
            var convertedPressure: Double
            
            convertedPressure = Double(hpaNum) / 33.864
            
            return Int(convertedPressure)
        }
        
        public func roundAndFormat(targetDouble: Double) -> String {
            let convertedDouble = targetDouble.rounded(.towardZero)
            
            return String(format: "%.0f", convertedDouble)
        }
        
        public func getForecastByCoord(lat: String, lon: String) async {
            //Create URL
            guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=imperial") else {
                print("Invalid URL")
                return
            }
            
            do {
                //Fetch data
                let (data, _) = try await URLSession.shared.data(from: url)
                
                //Decode result
                if let decodedResponse = try? JSONDecoder().decode(Forecast.self, from: data) {
                    self.forecast = decodedResponse
                    print(forecast)
                    return
                }
            } catch {
                print("Decoding Error")
            }
        }
    }
    
}
