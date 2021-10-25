//
//  ViewController.swift
//  Weather
//
//  Created by 박연배 on 2021/10/25.
//

import UIKit
import CoreLocation
import CoreLocationUI


class ViewController: UIViewController {

    
    //MARK: Property
    
    @IBOutlet weak var locationLabel: UILabel!
    
    let locationManager = CLLocationManager()
    var coordinate: CLLocation?
    
    //MARK: Method
    
    func getLocation() {
        
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
        case .restricted:
            print("제한")
        case .denied:
            print("거부")
        case .authorizedAlways:
            print("1")
        case .authorizedWhenInUse:
            print("2")
        case .authorized:
            print("3")
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
    
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }


}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coordinate = locations.last?.coordinate {
            
            
            locationManager.stopUpdatingLocation()
        }
        
    }
}
