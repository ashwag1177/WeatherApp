//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 15/12/1444 AH.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let city: String
    let temp: Double
    
    var tempString: String {
        return String(format: "%.1f ºF", temp)
    }
    
    var conditionName: String {
        switch conditionId {
        
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        case 904:
            return "sunny"
        default:
            return "cloud"
        }
    }
}





