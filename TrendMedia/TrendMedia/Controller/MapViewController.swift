//
//  MapViewController.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

class MapViewController: UIViewController {
    
    //MARK: Property
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterButtonClicked(_:)))
        button.tintColor = .darkGray
        return button
    }()
    
    var mapAnnotations: [TheaterLocation] = [
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        TheaterLocation(type: "롯데시네마", location: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        TheaterLocation(type: "메가박스", location: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        TheaterLocation(type: "메가박스", location: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
        TheaterLocation(type: "CGV", location: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        TheaterLocation(type: "CGV", location: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416)
    ]
    
    var filteredAnnotations = [TheaterLocation]() {
        didSet {
            fetchData()
        }
    }
    
    var locataionManager: CLLocationManager = CLLocationManager()
    
    var locationCoordinator: CLLocationCoordinate2D? {
        didSet {
            setLocation(latitude: locationCoordinator!.latitude, longitude: locationCoordinator!.longitude)
        }
    }
    
    var locality: String = UserDefaults.standard.string(forKey: "location") ?? "" {
        didSet {
            self.navigationItem.title = locality
            UserDefaults.standard.set(locality, forKey: "location")
        }
    }
    
    @IBOutlet weak var mapKitView: MKMapView!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    //MARK: Method
    
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        checkUsersLocationServicesAutorization()
    }
    
    
    func refreshButtonConfig() {
        refreshButton.backgroundColor = .systemIndigo
        refreshButton.tintColor = .white
        refreshButton.layer.cornerRadius = refreshButton.frame.size.width / 2
    }
    
    func filteringAnnotaions(type: String) {
        self.filteredAnnotations = mapAnnotations.filter({ $0.type == type })
    }
    
    func addAnnoation(data: TheaterLocation) {
        let annotaion = MKPointAnnotation()
        annotaion.coordinate = CLLocationCoordinate2D(latitude: data.latitude!, longitude: data.longitude!)
        annotaion.title = data.location!
        self.mapKitView.addAnnotation(annotaion)
    }
    
    func fetchData() {
        if filteredAnnotations.isEmpty {
            for data in mapAnnotations {
                addAnnoation(data: data)
            }
        } else {
            for data in filteredAnnotations {
                addAnnoation(data: data)
            }
        }
    }
    
    func setLocation(latitude: Double, longitude: Double){
        self.mapKitView.region.center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.mapKitView.region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
    
    
    // 사용자의 위치 서비스 권한 확인
    func checkUsersLocationServicesAutorization() {
        let auth: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            auth = locataionManager.authorizationStatus
        } else {
            auth = CLLocationManager.authorizationStatus()
        }
        // iOS 위치 서비스 권한 확인
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAutorization(status: auth)
        }
        
    }
    
    func checkCurrentLocationAutorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("설정되지 않았음")
            locataionManager.requestWhenInUseAuthorization()
            locataionManager.desiredAccuracy = kCLLocationAccuracyBest
            locataionManager.startUpdatingLocation()
        case .restricted, .denied:
            setLocation(latitude: 37.56674435790457, longitude: 126.9784350966443)
            print("제한됨. 설정으로 이동")
        case .authorizedAlways, .authorizedWhenInUse:
            print("이용가능")
            self.locataionManager.startUpdatingLocation()
            
        @unknown default:
            print("unknown")
        }
        
        if #available(iOS 14.0, *) {
            let accuracyState = locataionManager.accuracyAuthorization
            
            switch accuracyState {
            case .fullAccuracy:
                print("Full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Default")
            }
        }
    }
    
    func getCurrentAddress(location: CLLocation) {
        let coder = CLGeocoder()
        let locale = Locale(identifier: "ko-KR")
        coder.reverseGeocodeLocation(location, preferredLocale: locale) { (placemark, error) -> Void in
            guard error == nil, let place = placemark?.first else {
                print("주소 설정 불가능")
                return
            }
            
            if let administrativeArea = place.administrativeArea {
                print(administrativeArea)
            }
            if let locality = place.locality {
                self.locality = locality
                print(self.locality)
            }
            if let subLocality = place.subLocality {
                self.locality += " \(subLocality)"
                print(subLocality)
            }
            if let subThoroughfare = place.subThoroughfare {
                print(subThoroughfare)
            }
        }
        
    }
    
    //MARK: Objc Func
    
    @objc func filterButtonClicked(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cgvButton = UIAlertAction(title: "CGV", style: .default) { _ in
            self.filteringAnnotaions(type: "CGV")
            print(self.filteredAnnotations)
        }
        let megaBoxButton = UIAlertAction(title: "메가박스", style: .default, handler: nil)
        let lotteCinemaButton = UIAlertAction(title: "롯데시네마", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(cgvButton)
        alert.addAction(megaBoxButton)
        alert.addAction(lotteCinemaButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshButtonConfig()
        locataionManager.delegate = self
        mapKitView.delegate = self
        
        mapKitView.region.span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        fetchData()
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = locality
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            getCurrentAddress(location: CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude))
            self.locationCoordinator = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
            locataionManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUsersLocationServicesAutorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUsersLocationServicesAutorization()
    }
}

extension MapViewController: MKMapViewDelegate {
    
    
}