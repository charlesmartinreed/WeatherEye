//
//  AppDelegate.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    //MARK:- @IBOutlets
    //window outlet removed since this is a menu bar app
    //@IBOutlet weak var statusMenu: NSMenu! - refactored into StatusMenuController
    
    //adjusts to the width of its contents
//    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength) - refactored into StatusMenuController

    //MARK:- App Delegate methods
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        //refactored into StatusMenuController
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    
    
}

