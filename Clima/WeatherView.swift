//
//  ContentView.swift
//  Clima
//
//  Created by Raul Paneque on 11/8/22.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var viewModel:WeatherViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.cityname)
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.temperature)
                .font(.system(size: 70))
                .bold()
            
            Text(viewModel.weatherIcon)
                .font(.largeTitle)
                .padding()
            
            Text(viewModel.weatherDescription)
        }.onAppear(perform: viewModel.refresh)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherServices: WeatherServices()))
    }
}
