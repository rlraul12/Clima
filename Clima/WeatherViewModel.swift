//
//  WeatherViewModel.swift
//  Clima
//
//  Created by Raul Paneque on 11/8/22.
//

import Foundation

private let defaultIcon = "❓"
private let iconMap = [
    
    "Drizzle":"🌧️",
    "ThunderStorm":"⛈️",
    "Rain":"🌧️",
    "Snow":"❄️",
    "Clear":"☀️",
    "Clouds":"☁️"
    
]

class WeatherViewModel:ObservableObject{
    @Published var cityname:String = "City Name"
    @Published var temperature:String = "--"
    @Published var weatherDescription:String = "--"
    @Published var weatherIcon:String = defaultIcon
    
    public let weatherServices: WeatherServices
    
    init(weatherServices:WeatherServices){
        self.weatherServices = weatherServices
    }
    
    func refresh(){
        weatherServices.loadWeatherData{weather in
            DispatchQueue.main.async {
                self.cityname = weather.city
                self.temperature = "\(weather.temperature) C"
                self.weatherDescription = weather.description.capitalized
                self.weatherIcon = iconMap[weather.iconName] ?? defaultIcon
            }
            
        }
        
        
    }
}
