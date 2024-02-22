//
//  WeatherService.swift
//  Weather
//
//  Created by MD Tanvir Shaharia on 20/2/24.
//

import Foundation
import CoreLocation
public final class WeatherService : NSObject {
    private let locationManager = CLLocationManager()
    private let API_KEY = "fd50e70605b122e516c38bf0071838d6"
    private let leanguige = "English"
    private var compeletionHandler : ((Weather)-> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData (_ compeletionHandler : @escaping ((Weather)-> Void)){
        self.compeletionHandler = compeletionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}&lang={lang} request
    private func makeDataRequest (forCoordinats coordinates : CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&lang=\(leanguige)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {return}
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.compeletionHandler?(Weather(response: response))
                
            }
        }.resume()
    }
}
extension WeatherService : CLLocationManagerDelegate {
    public func locationManager (_ manager : CLLocationManager, didUpdateLocations locations : [CLLocation]){
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinats: location.coordinate)
    }
    public func locationManager (_ manager : CLLocationManager, didFailWithError error : Error){
        print("Something went wrong \(error.localizedDescription)")
    }
}

struct APIResponse : Decodable {
    let name : String
    let main : APIMain
    let weather : [APIWeather]
}

struct APIMain : Decodable {
    let temp : Double
}

struct APIWeather : Decodable {
    let description : String
    let iconName : String
    
    enum CodingKeys : String, CodingKey {
        case description
        case iconName = "main"
    }
}
