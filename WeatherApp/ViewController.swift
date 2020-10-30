//
//  ViewController.swift
//  WeatherApp
//
//  Created by wolfyteze on 30/10/2020.
//  Copyright © 2020 wolfyteze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var appearentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
   
    @IBAction func refreshButtonTapd(_ sender: UIButton) {
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let icon = WeatherIconManager.Cloudy.image
        let currentWeather = CurrentWeather(temperature: 10.0,
                                            appearentTemperature: 7.0,
                                            humidity: 30.0,
                                            pressure: 755.0,
                                            icon: icon)
        updateUIWith(currentWeather: currentWeather)
    }

    func updateUIWith(currentWeather: CurrentWeather){
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
}


