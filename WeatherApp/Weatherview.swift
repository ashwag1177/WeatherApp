//
//  ViewController.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 14/12/1444 AH.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

class Weatherview: UIViewController, NSFetchedResultsControllerDelegate {
    
  
    
    @IBOutlet weak var searchcity: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    var dataController: DataController!
    var fetchedResultsController:NSFetchedResultsController<City>!
    var city: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchcity.delegate = self
        weatherManager.delegate = self
        activityIndicator.isHidden = true
     
    }
    
    @IBAction func DismissKeybored(_ sender: Any) {
        searchButton.resignFirstResponder()
        
    }
    
    func setUpFetchResultsController() {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "cityName", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "city")
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            if fetchedResultsController.fetchedObjects?.count == 0 {
                print("No city found!")
            } else {
                var cities = fetchedResultsController.fetchedObjects!
                for city in cities {
                    cities.append(city)
                }
            }
        } catch {
            fatalError("The fetch could not be performed because of \(error.localizedDescription)")
        }
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let city = City(context: dataController.viewContext)
        city.cityName = cityLabel.text
        city.temperature = tempLabel.text
        try? dataController.viewContext.save()
       
       
    }
}



extension Weatherview: UITextFieldDelegate {
    @IBAction func searchButton(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        searchcity.endEditing(true)
        activityIndicator.hidesWhenStopped = true
        
        
        if let citytext = self.cityLabel.text , citytext.isEmpty{
            let alert = UIAlertController(title: "Error", message: "city empty , enter valid city.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: {
              return
            })
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchcity.text != "" {
            return true
        } else {
            textField.placeholder = "Enter city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
     
        if let city = searchcity.text {
            weatherManager.fetchWeather(cityName: city)
            
        }
       
    }
    
    
}


extension Weatherview: WeatherManagerDel {
    
    fileprivate func configureActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.hidesWhenStopped = true
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async { [self] in
            self.tempLabel.text = weather.tempString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.city
            configureActivityIndicator()
        }
    }
    
    func didFailWithError(error: Error) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "filled internet connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.configureActivityIndicator()
        }
        print(error.localizedDescription)
    }
    
}



