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
    @IBOutlet weak var statusMenu: NSMenu!
    
    //adjusts to the width of its contents
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    //MARK:- App Delegate methods
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        //Intiaization for menu
        statusItem.button?.title = "WeatherEye"
        statusItem.menu = statusMenu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    //MARK:- @IBActions
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        //the app should terminate itself
        NSApplication.shared.terminate(self)
    }
    
}

