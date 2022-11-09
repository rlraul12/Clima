//
//  WeatherServices.swift
//  Clima
//
//  Created by Raul Paneque on 11/8/22.
//
import CoreLocation
import Foundation

public final class WeatherServices:NSObject{
    private let locationManager = CLLocationManager()
    private let API_KEY = "f45aa9a2e7349f5c4ac3892839d224dd"
    private var completioHandler: ((Weather)->Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    public func loadWeatherData(_ completioHandler: @escaping((Weather)->Void)){
        self.completioHandler = completioHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D){
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {return}
            
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data){
                let wheather = Weather(response: response)
                self.completioHandler?(wheather)
            }
        }.resume()
    }
}

extension WeatherServices:CLLocationManagerDelegate{
    
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first else {return}
        makeDataRequest(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error.localizedDescription)")
    }
}

struct APIResponse:Decodable{
    let name:String
    let main:APIMain
    let weather:[APIWeather]
}

struct APIMain:Decodable{
    let temp:Double
}

struct APIWeather:Decodable {
    let description: String
    let iconName: String
    
    enum CodingKeys:String,CodingKey{
        case description
        case iconName = "main"
    }
}
