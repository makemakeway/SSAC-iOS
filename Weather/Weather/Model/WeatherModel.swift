//
//  WeatherModel.swift
//  Weather
//
//  Created by 박연배 on 2021/10/26.
//

import Foundation

struct WeatherModel {
    var clouds: Int
    var weather: Weather
    var main: Main
    var wind: Wind
}


struct Weather {
    var main: String
    var icon: String
    var id: Int
    var description: String
}

struct Main {
    var tempMax: Double
    var feelsLike: Double
    var tempMin: Double
    var humidity: Int
    var pressure: Int
    var temp: Double
}

struct Wind {
    var speed: Double
    var deg: Int
}
