//
//  WeatherView.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Cocoa

class WeatherView: NSView {

    //MARK:- @IBOutlets
    @IBOutlet weak var imageView: NSImageView!
    @IBOutlet weak var cityTextField: NSTextField!
    @IBOutlet weak var currentConditionsTextField: NSTextField!
    
    func update(_ weather: Weather) {
        //remember, always do UI updates on the main thread. Also, the update for weather happens from a networking thread.
        DispatchQueue.main.async {
            self.cityTextField.stringValue = weather.city
            self.currentConditionsTextField.stringValue = "\(weather.currentTemp)F and \(weather.currentConditions)"
            //self.imageView.image = NSImage(named: "\(weather.icon)")
        }
    }
    
    
}
