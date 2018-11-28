//
//  StatusMenuController.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let weatherAPI = WeatherAPI() //instantiate WeatherAPI
    
    override func awakeFromNib() {
        //Intiaization for menu
        //statusItem.button?.title = "WeatherEye"
        //statusItem.menu = statusMenu
        
        //Init for App Icon
        guard let icon = NSImage(named: "statusIcon") else {
            //just dicking around here, this code should never run
            statusItem.button?.title = "WeatherEye"
            statusItem.menu = statusMenu
            return
        }
        
        icon.isTemplate = true // for dark mode -  produces only black or clear images
        statusItem.button?.image = icon
        statusItem.menu = statusMenu
        
        //update weather on load
        updateWeather()
    }
    
    //MARK:- Class methods
    func updateWeather() {
        weatherAPI.fetchWeather("Seattle") { (weather) in
            NSLog(weather.description)
        }
    }
    
    //MARK:- @IBActions
    @IBAction func updateClicked(_ sender: NSMenuItem) {
        updateWeather()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        //the app should terminate itself
        NSApplication.shared.terminate(self)
    }

}
