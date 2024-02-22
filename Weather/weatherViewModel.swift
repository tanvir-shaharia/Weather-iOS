//
//  weatherViewModel.swift
//  Weather
//
//  Created by MD Tanvir Shaharia on 20/2/24.
//

import Foundation

private let defaultIcon = "?"
private let iconMap = [
    "Drizzle" : "💦",
    "Thunderstom" : "⛈️",
    "Rain" : "🌧️",
    "Snow" : "❄️",
    "Clear" : "☀️",
    "Clouds" : "☁️"
]

public class WeatherViewModel : ObservableObject {
    @Published var cityName : String = "City Name "
    @Published var temperature : String = "--"
    @Published var weatherDesscription : String = "--"
    @Published var weatherIcon : String = "--"
    
    public let weatherService : WeatherService
    
    public init (weatherService : WeatherService) {
        self.weatherService = weatherService
    }
    public func refresh (){
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)°C"
                self.weatherDesscription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
        }
    }
}
