//
//  ContentView.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/21/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @StateObject var locationManager = LocationManager()
    var degreeSymbol = "\u{00B0}"
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        ZStack {
            Color
                .blue
                .ignoresSafeArea(.all)
            VStack {
                
                Text("\(viewModel.forecast.name)")
                    .font(.system(size: 32, weight: .bold))
                    .padding([.top], 30)
                
                Image(systemName: viewModel.translateWeatherCode(descCode: viewModel.forecast.weather[0].main))
                 .renderingMode(.original)
                 .resizable()
                 .frame(width: 180, height: 150)
                
                Text("\(viewModel.roundAndFormat(targetDouble: viewModel.forecast.main.temp))\(degreeSymbol)")
                    .font(.system(size: 75, weight: .heavy))
                    .padding([.top, .bottom], 5)
                
                Text("\(viewModel.forecast.weather[0].main)")
                    .font(.system(size: 25))
                    .padding([.bottom], 5)
                
                HStack {
                    Text("L: \(viewModel.roundAndFormat(targetDouble: viewModel.forecast.main.temp_min))\(degreeSymbol)")
                        .padding([.trailing], 5)
                    Text("H: \(viewModel.roundAndFormat(targetDouble: viewModel.forecast.main.temp_max))\(degreeSymbol)")
                        .padding([.leading], 5)
                }
                .font(.system(size: 25))
                
                VStack {
                    HStack {
                        StatView(title: "Feels Like", stat: Int(viewModel.forecast.main.feels_like), unit: "\(degreeSymbol)")
                        StatView(title: "Wind", stat: Int(viewModel.forecast.wind.speed), unit: "mph")
                    }
                    
                    HStack {
                        StatView(title: "Pressure", stat: viewModel.convertPressure(hpaNum: viewModel.forecast.main.pressure), unit: "inHg")
                        StatView(title: "Humidity", stat: viewModel.forecast.main.humidity, unit: "%")
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        .alert("No API Key, refer to Github documentation", isPresented: $viewModel.showAlert) {
            Button("Dismiss") {}
        }
        .onChange(of: scenePhase) { newPhase in
            if (newPhase == .background) {
                Task {
                    viewModel.checkApiStatus()
                    
                    await viewModel.getForecastByCoord(lat: locationManager.getLat(), lon: locationManager.getLon())
                    
                    locationManager.stopUpdating()
                }
            }
        }
        .task {
            viewModel.checkApiStatus()
            
            await viewModel.getForecastByCoord(lat: locationManager.getLat(), lon: locationManager.getLon())
            
            locationManager.stopUpdating()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
