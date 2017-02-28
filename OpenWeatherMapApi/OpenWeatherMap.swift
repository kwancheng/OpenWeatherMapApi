//
//  OpenWeatherMap.swift
//  OpenWeatherMapApi
//
//  Created by Cheng, Yu Kwan on 2/28/17.
//  Copyright © 2017 GhengisKwan. All rights reserved.
//

import Foundation

public protocol OpenWeatherMapDelegate {
    func hasWeatherData(responseJson : [String:Any])
    func failedToQueryWeather(response: URLResponse?, error:Error?, otherMsg : String?)
}

public class OpenWeatherMap {
    private let API_KEY = "936b99fb56422dbe0f15c97d7801becb" // TODO: Provide initializer for user supplied
    private let API_URL_STR = "http://api.openweathermap.org/data/2.5/" //TODO: Provide intializer for user supplied
    
    private let SAMPLE_URL_STR = "http://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1"
    
    public var delegate : OpenWeatherMapDelegate?
    
    private let aSession = URLSession(configuration: URLSessionConfiguration.default)
    private var pendingQuery : URLSessionDataTask?
    
    public init() {}
    
    public func getWeather(for city:String, and country:String?=nil) {
        if pendingQuery != nil {
            pendingQuery?.cancel()
        }

//        var qVal = city
//        if let country = country {
//            qVal.append(",\(country)")
//        }
//
//        guard let initialUrl = URL(string: API_URL_STR)?.appendingPathComponent("weather") else {
//            // TODO : Throw error or find a way t silent fail
//            return
//        }
//        
//        guard var urlComponents = URLComponents(url: initialUrl, resolvingAgainstBaseURL: false) else {
//            // TODO : Throw error or find a way to silent fail
//            return
//        }
//
//        urlComponents.queryItems = [
//            URLQueryItem(name:"q", value:qVal),
//            URLQueryItem(name: "type", value: "like"),
//            URLQueryItem(name: "appid", value: API_KEY)
//        ]
//        
//        guard let url = urlComponents.url else {
//            // TODO: Throw error or find a way to silent fail
//            return
//        }
        
        // Use sample until account issue is resolved
        guard let url = URL(string: SAMPLE_URL_STR) else {
            // TODO: THRow error or find a way to silent fail
            return
        }
        
        pendingQuery = aSession.dataTask(with: url, completionHandler: { (data, response, error) in
            self.pendingQuery = nil
            guard error?.localizedDescription == nil else {
                self.delegate?.failedToQueryWeather(response:response, error:error, otherMsg:nil)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                self.delegate?.failedToQueryWeather(response: response, error: error, otherMsg: "Not an HTTP response.")
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                self.delegate?.failedToQueryWeather(response: response, error: error, otherMsg: "Query Failed StatusCode[\(httpResponse.statusCode)]")
                return
            }
            
            guard let data = data else {
                self.delegate? .failedToQueryWeather(response: response, error: error, otherMsg: "No errors, but no data in response.")
                return
            }

            let dataStr = String(data: data, encoding: .utf8)
            print("Response - \(dataStr)")
            
            if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), let json = jsonObject as? [String: Any] {
                    self.delegate?.hasWeatherData(responseJson: json)
            } else {
                self.delegate?.failedToQueryWeather(response: response, error: error, otherMsg: "Failed to convert response to json dictionary. Data [\(dataStr)]")
            }
        })
        pendingQuery?.resume()
    }
}
