//
//  WeatherAPI.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

class WeatherAPI {
    let apiKey = "99e5cefe299c0dbc3d635bf2d124364f"
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeather(_ query: String) {
        let session = URLSession.shared //grab the singleton object
        
        // url-escape the query string we're passed during method call
        let escapedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "\(baseURL)?APPID=\(apiKey)&units=imperial&q=\(escapedQuery!)")
        let task = session.dataTask(with: url!) { (data, response, err) in
            //check for an error
            if let error = err {
                NSLog("weather api error: \(error)")
            }
            
            //if no error, we'll check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: //OK
                    if let dataString = String(data: data!, encoding: .utf8) {
                        NSLog(dataString)
                    }
                case 401: //unauthorized
                    NSLog("weather api returned an 'unauthorized response', check that your API key was properly set")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        
        task.resume()
    }
}
