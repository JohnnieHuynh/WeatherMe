//
//  LoadingScreen.swift
//  WeatherMe
//
//  Created by Johnny Huynh on 3/25/23.
//

import SwiftUI

struct LoadingScreen: View {
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        ZStack {
            Color
                .blue
                .ignoresSafeArea(.all)
            if locationManager.loading == true {
                ProgressView()
            } else {
                ContentView()
            }
        }
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
