//
//  ViewController.swift
//  Weather
//
//  Created by 박연배 on 2021/10/25.
//

import UIKit
import CoreLocation
import CoreLocationUI
import Alamofire
import SwiftyJSON
import Kingfisher


class ViewController: UIViewController {

    
    //MARK: Property
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    
    let locationManager = CLLocationManager()
    var location: String? {
        didSet {
            self.locationLabel.text = location
        }
    }
    var coordinate: CLLocationCoordinate2D?
    
    var weatherData: WeatherModel? {
        didSet {
            self.settingLayout()
        }
    }
    
    //MARK: Method
    
    func makeAlert(title: String?, message: String?, buttonTitle1: String, buttonTitle2: String, completion: @escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: buttonTitle1, style: .default) { _ in
            completion()
        }
        let cancelButton = UIAlertAction(title: buttonTitle2, style: .default, handler: nil)
        
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func getLocation(location: CLLocation) {
        let coder = CLGeocoder()
        let locale = Locale(identifier: "ko-KR")
        coder.reverseGeocodeLocation(location, preferredLocale: locale) { placeMark, error in
            guard error == nil, let place = placeMark?.first else {
                return
            }
            if let admini = place.administrativeArea, let city = place.locality {
                self.location = admini + " " + city
            }
            
        }
    }
    
    func checkUserLocationServiceAuthorization() {
        let authStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authStatus = locationManager.authorizationStatus
        } else {
            authStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(status: authStatus)
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("결정하지않음")
            locationManager.requestWhenInUseAuthorization()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            self.makeAlert(title: "위치정보 권한 필요",
                      message: "서비스 제공을 위해 위치정보가 필요합니다.",
                      buttonTitle1: "설정하러 가기!!",
                      buttonTitle2: "응 안해~~") {
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        case .authorized:
            print("인가됨")
        @unknown default:
            print("unknown")
        }
        
        
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduce")
            @unknown default:
                print("unknown")
            }
        }
    }
    
    func getCurrentWeather() {
        
        guard let latitude = coordinate?.latitude, let longitude = coordinate?.longitude else {
            return
        }
        
        let lat = String(format: "%f", latitude)
        let lon = String(format: "%f", longitude)
        
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIS.shared.openWeatherApiKey)"
        
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                let document = json["weather"][0]
                
                let weather = Weather(main: document["main"].stringValue,
                                      icon: document["icon"].stringValue,
                                      id: document["id"].intValue,
                                      description: document["description"].stringValue)
                let clouds = json["clouds"]["all"].intValue
                let main = json["main"]
                let wind = json["wind"]
                
                self.weatherData = WeatherModel(clouds: clouds,
                                                weather: weather,
                                                main: Main(tempMax: main["temp_max"].doubleValue,
                                                           feelsLike: main["feels_like"].doubleValue,
                                                           tempMin: main["temp_min"].doubleValue,
                                                           humidity: main["humidity"].intValue,
                                                           pressure: main["pressure"].intValue,
                                                           temp: main["temp"].doubleValue),
                                                wind: Wind(speed: wind["speed"].doubleValue,
                                                           deg: wind["deg"].intValue))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func settingLayout() {
        guard let data = self.weatherData else {
            return
        }
        guard let url = URL(string: "https://openweathermap.org/img/wn/\(data.weather.icon)@4x.png") else {
            print("bad image url")
            return
        }
        
        self.humidityLabel.text = "현재 습도는 \(data.main.humidity)% 입니다."
        self.currentTempLabel.text = "현재 온도는 \(Int(data.main.temp - 273.15))°C 입니다."
        self.windSpeedLabel.text = "현재 풍속은 \(data.wind.speed)m/s 입니다."
        self.weatherImage.kf.setImage(with: url, placeholder: nil, options: nil)
    }
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkUserLocationServiceAuthorization()
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            
            getLocation(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            
            self.coordinate = coordinate
            
            getCurrentWeather()
            locationManager.stopUpdatingLocation()
        }
        
    }
}
