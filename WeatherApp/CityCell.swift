//
//  CityCell.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 15/12/1444 AH.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    func insertData(model: City) {
        if cityLabel.text != nil {
            cityLabel.text = model.cityName
        }
        
        if tempLabel.text != nil {
            tempLabel.text = model.temperature
        }
        
    }
    
}

