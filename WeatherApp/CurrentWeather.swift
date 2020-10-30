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

extension CurrentWeather: JSONDecodable {
  init?(JSON: [String : AnyObject]) {
    guard let temperature = JSON["temperature"] as? Double,
    let apparentTemperature = JSON["apparentTemperature"] as? Double,
    let humidity = JSON["humidity"] as? Double,
    let pressure = JSON["pressure"] as? Double,
      let iconString = JSON["icon"] as? String else {
        return nil
    }
    
    let icon = WeatherIconManager(rawValue: iconString).image
    
    self.temperature = temperature
    self.appearentTemperature = apparentTemperature
    self.humidity = humidity
    self.pressure = pressure
    self.icon = icon
    
  }
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
