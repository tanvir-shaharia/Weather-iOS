//
//  ContentView.swift
//  Weather
//
//  Created by MD Tanvir Shaharia on 20/2/24.
//

import SwiftUI

struct WeatherView: View {
     
    @ObservedObject var viewModel : WeatherViewModel
    @State private var isShowingProgressBar = false
    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(
                            gradient: Gradient(colors: [Color.red, Color.blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    Text(viewModel.temperature)
                        .font(.system(size: 70))
                        .foregroundColor(.white)
                        .bold()
                    Text(viewModel.weatherIcon)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    Text(viewModel.weatherDesscription)
                        .foregroundColor(.white)
                    Button {
                        isShowingProgressBar = true
                        viewModel.refresh()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                isShowingProgressBar = false
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 30,height: 30)
                    }
                    .padding(.top)
                    
                }
                .onAppear{
                    viewModel.refresh()
                }
                .overlay(
                    // Overlay ProgressView when isShowingProgressBar is true
                    isShowingProgressBar ? ProgressView() : nil
                )
                .onDisappear {
                    isShowingProgressBar = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}
