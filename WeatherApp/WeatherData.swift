//
//  WeatherData.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 15/12/1444 AH.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

