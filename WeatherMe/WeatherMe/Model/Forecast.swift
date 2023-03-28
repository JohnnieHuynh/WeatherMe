//
//  Forecast.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/21/23.
//

import Foundation

struct Forecast: Codable {
    var name: String
    var coord: Coord
    var weather: [Weather]
    var main: Main
    var wind: Wind
    
    init() {
        self.name = ""
        self.coord = Coord(lon: 0.0, lat: 0.0)
        self.weather = [Weather(main: "", description: "", icon: "")]
        self.main = Main(temp: 0, feels_like: 0.0, temp_min: 0.0, temp_max: 0.0, pressure: 0, humidity: 0)
        self.wind = Wind(speed: 0.0)
    }
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
    
    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

struct Weather: Codable {
    var main: String
    var description: String
    var icon: String
    
    init(main: String, description: String, icon: String) {
        self.main = main
        self.description = description
        self.icon = icon
    }
}

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    
    init(temp: Double, feels_like: Double, temp_min: Double, temp_max: Double, pressure: Int, humidity: Int) {
        self.temp = temp
        self.feels_like = feels_like
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
    }
}

struct Wind: Codable {
    var speed: Double
    
    init(speed: Double) {
        self.speed = speed
    }
}
