//
//  ClimaApp.swift
//  Clima
//
//  Created by Raul Paneque on 11/8/22.
//

import SwiftUI

@main
struct ClimaApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView(viewModel: WeatherViewModel(weatherServices:WeatherServices()))
        }
    }
}
