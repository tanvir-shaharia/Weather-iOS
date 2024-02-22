//
//  ContentView.swift
//  Weather
//
//  Created by MD Tanvir Shaharia on 22/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isActive {
                    WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
                } else {
                    SplashScreen(isActive: $isActive)
                }
            }
        }
    }
}
