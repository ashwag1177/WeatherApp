//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by  ashwaq marzouq on 14/12/1444 AH.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataController = DataController(modelName: "Weather")
    


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        
        let navigationController = window?.rootViewController as? UITabBarController
        let weatherViewController = navigationController?.viewControllers?[0] as! Weatherview
        weatherViewController.dataController = dataController
        dataController.load()
        
        let savedVIewController = navigationController?.viewControllers?[1] as! SaveTheCity
        savedVIewController.dataController = dataController
        
        
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    



}

