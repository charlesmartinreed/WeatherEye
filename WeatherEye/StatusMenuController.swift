//
//  StatusMenuController.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Cocoa
let defaultCity = "Dallas" //sorta taking the easy way out here by using global var instead of something like user defaults

class StatusMenuCon
troller: NSObject, PreferencesWindowDelegate {
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var weatherView: WeatherView!
    
    //class var for the WeatherView pane
    var weatherMenuItem: NSMenuItem!
    var preferencesWindow: PreferencesWindow!
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let weatherAPI = WeatherAPI() //instantiate WeatherAPI
    
    override func awakeFromNib() {
        //set the delegate
        preferencesWindow = PreferencesWindow()
        preferencesWindow.delegate = self
        
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
        
        //initialize the PreferencesWindow
        preferencesWindow = PreferencesWindow()
        
        //update weather on load
        weatherMenuItem = statusMenu.item(withTitle: "Weather")
        weatherMenuItem.view = weatherView
        updateWeather()
        
    }
    
    //MARK:- Delegate methods
    func preferencesDidUpdate() {
        updateWeather()
    }
    
    //MARK:- Class methods
    func updateWeather() {
        let defaults = UserDefaults.standard
        let city = defaults.string(forKey: "city") ?? defaultCity
        weatherAPI.fetchWeather(city) { (weather) in
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
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    

}
