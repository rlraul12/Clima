//
//  Weather.swift
//  Clima
//
//  Created by Raul Paneque on 11/8/22.
//

import Foundation

public struct Weather{
    let city:String
    let description:String
    let temperature:String
    let iconName:String
    
    init(response: APIResponse){
        city = response.name
        temperature = "\(Int(response.main.temp))"
        description = response.weather.first?.description ?? ""
        iconName = response.weather.first?.iconName ?? ""
    }
}
