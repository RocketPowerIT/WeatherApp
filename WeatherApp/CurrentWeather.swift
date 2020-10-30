//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by wolfyteze on 30/10/2020.
//  Copyright © 2020 wolfyteze. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
  let temperature: Double
  let appearentTemperature: Double
  let humidity: Double
  let pressure: Double
  let icon: UIImage
}

extension CurrentWeather {

    var pressureString: String {
        return "\(Int(pressure)) mm"
    }
    
    var temperatureString: String {
        return "\(Int(temperature))˚C"
    }
    
    var appearentTemperatureString: String {
        return "Feels likes: \(Int(appearentTemperature))˚C"
    }
    
    var humidityString: String {
        return "\(Int(humidity))%"
    }
}
