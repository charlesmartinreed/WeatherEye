//
//  PreferencesWindow.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Cocoa

//we'll use the delegate method to let the view controller's know that data has been updated
protocol PreferencesWindowDelegate {
    func preferencesDidUpdate()
}

class PreferencesWindow: NSWindowController, NSWindowDelegate {

    var delegate: PreferencesWindowDelegate?
    
    //MARK:- @IBOutlets
    @IBOutlet weak var cityTextField: NSTextField!
    
    //link to our custom xib
    override var windowNibName: String! {
        return "PreferencesWindow"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        //load the default city
        let defaults = UserDefaults.standard
        let city = defaults.string(forKey: "city") ?? defaultCity
        cityTextField.stringValue = city
        
        //position the window, move it to the front of the window stack, make ours the active app
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    //MARK:- Delegate method
    func windowWillClose(_ notification: Notification) {
        //save to the user defaults area when we close out
        let defaults = UserDefaults.standard
        defaults.set(cityTextField.stringValue, forKey: "city")
        
        //call the delegate
        delegate?.preferencesDidUpdate()
    }
    
}
