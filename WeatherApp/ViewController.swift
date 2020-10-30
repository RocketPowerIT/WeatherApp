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
    
    lazy var weatherManager = APIWeatherManager(apiKey: "2a6d8e376a69c1ae07d4a52dd0c2dfdc")
    let coordinates = Coordinates(latitude: 54.741704, longitude: 55.984471)
    
    override func viewDidLoad() {
      super.viewDidLoad()

      weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
        switch result {
        case .Success(let currentWeather):
          self.updateUIWith(currentWeather: currentWeather)
        case .Failure(let error as NSError):
          
          let alertController = UIAlertController(title: "Unable to get data ", message: "\(error.localizedDescription)", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alertController.addAction(okAction)
          
          self.present(alertController, animated: true, completion: nil)
        default: break
        }
      }
    }

    func updateUIWith(currentWeather: CurrentWeather){
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.appearentTemperatureLabel.text = currentWeather.appearentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
}


