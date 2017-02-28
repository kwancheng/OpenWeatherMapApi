//
//  WeatherResponse.swift
//  OpenWeatherMapApi
//
//  Created by Cheng, Yu Kwan on 2/28/17.
//  Copyright © 2017 GhengisKwan. All rights reserved.
//

import Foundation
import Gloss

public class WeatherResponse : Decodable, CustomStringConvertible {
    let coord : CoordinateResponse?
    let weathers : [WeatherItemResponse]?
    let base : String?
    let main : MainResponse?
    let visibility : Decimal?
    let wind : WindResponse?
    let clouds : CloudsResponse?
    let dt : Decimal?
    let sys : SysResponse?
    let id : Decimal?
    let name : String?
    let cod : Decimal?
    
    public required init(json:JSON) {
        self.coord = "coord" <~~ json
        self.weathers = "weather" <~~ json
        self.base = "base" <~~ json
        self.main = "main" <~~ json
        self.visibility = "visibility" <~~ json
        self.wind = "wind" <~~ json
        self.clouds = "clouds" <~~ json
        self.dt = "dt" <~~ json
        self.sys = "sys" <~~ json
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.cod = "cod" <~~ json
    }
    
    public var description: String {
        var retString = ""

        if let coord = self.coord {
            retString.append("Coord : \(coord)\n")
        }
        
        retString.append("Weather : \n")
        weathers?.forEach({ (weather) in
            retString.append("\(weather)\n")
        })
        
        retString.append("Base : \(base ?? "Unknown")\n")
        
        if let main = main {
            retString.append("Main : \(main)\n")
        }
        
        if let visibility = visibility {
            retString.append("Visibility : \(visibility)\n")
        }
        
        if let wind = wind {
            retString.append("Wind : \(wind)\n")
        }
        
        if let clouds = clouds {
            retString.append("Clouds : \(clouds)\n")
        }
        
        if let dt = dt {
            retString.append("DT : \(dt)\n")
        }
        
        if let sys = sys {
            retString.append("Sys : \(sys)\n")
        }
        
        if let id = id {
            retString.append("ID : \(id)\n")
        }
        
        if let name = name {
            retString.append("Name : \(name)\n")
        }
        
        if let cod = cod {
            retString.append("Code : \(cod)\n")
        }
        
        return retString
    }
}

public class CoordinateResponse : Decodable, CustomStringConvertible {
    let lon : Decimal?
    let lat : Decimal?
    
    public required init?(json: JSON) {
        self.lon = "lon" <~~ json
        self.lat = "lat" <~~ json
    }
    
    public var description: String {
        let latStr = lat != nil ? "\(lat!)" : "Unknown"
        let lonStr = lon != nil ? "\(lon!)" : "Unknown"
        return "lat : \(latStr), lon : \(lonStr)"
    }
}

public class WeatherItemResponse : Decodable, CustomStringConvertible {
    let id : Decimal?
    let main : String?
    let desc : String?
    let icon : String?
    
    public required init?(json:JSON){
        self.id = "id" <~~ json
        self.main = "main" <~~ json
        self.desc = "description" <~~ json
        self.icon = "icon" <~~ json
    }
    
    public var description: String {
        var retStr = "\tID:\(id != nil ? "\(id!)" : "Unknown")\n"
        retStr.append("\tMain:\(main != nil ? "\(main!)" : "Unknown")\n")
        retStr.append("\tDesc:\(desc != nil ? "\(desc!)" : "Unknown")\n")
        retStr.append("\tIcon:\(icon != nil ? "\(icon!)" : "Unknown")\n")
        
        return retStr
    }
}

public class MainResponse :Decodable, CustomStringConvertible {
    let temp : Decimal?
    let pressure : Decimal?
    let humidity : Decimal?
    let tempMin : Decimal?
    let tempMax : Decimal?
    
    public required init?(json:JSON) {
        self.temp = "temp" <~~ json
        self.pressure = "pressure" <~~ json
        self.humidity = "humidity" <~~ json
        self.tempMin = "temp_min" <~~ json
        self.tempMax = "temp_max" <~~ json
    }
    
    public var description: String {
        var retStr = ""
        
        retStr.append("\n\tTemp:\(temp != nil ? "\(temp!)" : "Unknown")\n")
        retStr.append("\tPressure:\(pressure != nil ? "\(pressure!)" : "Unknown")\n")
        retStr.append("\tHumidity:\(humidity != nil ? "\(humidity!)" : "Unknown")\n")
        retStr.append("\tTempMin:\(tempMin != nil ? "\(tempMin!)" : "Unknown")\n")
        retStr.append("\tTempMax:\(tempMax != nil ? "\(tempMax!)" : "Unknown")\n")
        
        return retStr
    }
}

public class WindResponse : Decodable, CustomStringConvertible {
    let speed : Decimal?
    let deg : Decimal?
    
    public required init?(json:JSON) {
        self.speed = "speed" <~~ json
        self.deg = "deg" <~~ json
    }
    
    public var description: String {
        return "SPD:\(speed != nil ? "\(speed!)" : "Unknown") DIR:\(deg != nil ? "\(deg!)" : "Unknown")"
    }
}

public class CloudsResponse : Decodable, CustomStringConvertible {
    let all : Decimal?
    
    public required init?(json: JSON){
        self.all = "all" <~~ json
    }
    
    public var description: String {
        return "\(all != nil ? "\(all!)" : "Unknown")"
    }
}

public class SysResponse : Decodable, CustomStringConvertible  {
    let type : Decimal?
    let id : Decimal?
    let message : Decimal?
    let country : String?
    let sunrise : Decimal?
    let sunset : Decimal?
    
    public required init?(json: JSON) {
        self.type = "type" <~~ json
        self.id = "id" <~~ json
        self.message = "message" <~~ json
        self.country = "country" <~~ json
        self.sunrise = "sunrise" <~~ json
        self.sunset = "sunset" <~~ json
    }
    
    public var description: String {
        var retStr = "\n\tType:\(type != nil ? "\(type!)" : "Unknown")\n"
        retStr.append("\tID:\(id != nil ? "\(id!)" : "Unknown")\n")
        retStr.append("\tMessage:\(message != nil ? "\(message!)" : "Unknown")\n")
        retStr.append("\tCountry:\(country != nil ? "\(country!)" : "Unknown")\n")
        
        let df = DateFormatter()
        df.dateStyle = .full
        
        var sunriseStr = "Unknown"
        if let sunrise = sunrise {
            let d = NSDecimalNumber(decimal: sunrise)
            sunriseStr = df.string(from: Date(timeIntervalSince1970: d.doubleValue))
        }
        retStr.append("\tSunrise:\(sunriseStr)\n")
        
        var sunsetStr = "Unknown"
        if let sunset = sunset {
            let d = NSDecimalNumber(decimal: sunset)
            sunsetStr = df.string(from: Date(timeIntervalSince1970: d.doubleValue))
        }
        retStr.append("\tSunset:\(sunsetStr)\n")
        
        return retStr
    }
}
