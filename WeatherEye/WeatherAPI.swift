//
//  WeatherAPI.swift
//  WeatherEye
//
//  Created by Charles Martin Reed on 11/27/18.
//  Copyright © 2018 Charles Martin Reed. All rights reserved.
//

import Foundation

//MARK:- Structs
struct Weather: CustomStringConvertible {
    
    var city: String
    var currentTemp: Float
    var currentConditions: String
    var icon: String
    
    var description: String {
        return "\(city): \(currentTemp)F and \(currentConditions)"
    }
    
}

class WeatherAPI {
    let apiKey = "99e5cefe299c0dbc3d635bf2d124364f"
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    //MARK:- GET weather data
    //expect a function that takes a Weather obj, @escaping because the function calls out of fetchWeather
    func fetchWeather(_ query: String, success: @escaping (Weather) -> Void) {
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
//                    if let dataString = String(data: data!, encoding: .utf8) {
//                        NSLog(dataString)
//                    }
                    if let weather = self.weatherFromJSONData(data!) {
                        //NSLog("\(weather)")
                        success(weather) //callback function
                    }
                case 401: //unauthorized
                    NSLog("weather api returned an 'unauthorized response', check that your API key was properly set")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        print("This is the url: \(url!)")
        task.resume()
    }
    
    //MARK:- PARSE weather data
    func weatherFromJSONData(_ data: Data) -> Weather? {
        typealias JSONDict = [String:AnyObject]
        let json: JSONDict
        
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! JSONDict
        } catch {
            NSLog("JSON parsing failed: \(error)") //JSONSerialization can throw error, that's what we're referencing here
            return nil
        }
        
        //assigning the pulled data, if available
        var mainDict = json["main"] as! JSONDict //grab a dict, this has our temps
        var weatherList = json["weather"] as! [JSONDict] //make a weather list dict
        var weatherDict = weatherList[0] //grab the first result from that created dict
        
        //for whatever reason, Xcode and Swift can't cast to Float from NSNumber directly, so we need to cast it as a NSNumber and then convert floatValue
        let weather = Weather(city: json["name"] as! String,
                              currentTemp: (mainDict["temp"] as? NSNumber)?.floatValue ?? 0,
                              currentConditions: weatherDict["main"] as! String,
                              icon: weatherDict["icon"] as! String)
        
        return weather
    }
    
}
