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
    @IBOutlet weak var weatherView: WeatherView!
    
    //class var for the WeatherView pane
    var weatherMenuItem: NSMenuItem!
    
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
        weatherMenuItem = statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view = weatherView
        updateWeather()
    }
    
    //MARK:- Class methods
    func updateWeather() {
        weatherAPI.fetchWeather("Seattle") { (weather) in
            //add the weather info into the menu item we created in xib
//            if let weatherMenuItem = self.statusMenu.item(withTitle: "Weather") {
//                weatherMenuItem.title = weather.description
//            }
            self.weatherView.update(weather)
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
