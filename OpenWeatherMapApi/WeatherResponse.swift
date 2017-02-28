//
//  WeatherResponse.swift
//  OpenWeatherMapApi
//
//  Created by Cheng, Yu Kwan on 2/28/17.
//  Copyright © 2017 GhengisKwan. All rights reserved.
//

import Foundation
import Gloss

public class WeatherResponse : Decodable {
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
}

public class CoordinateResponse : Decodable {
    let lon : Decimal?
    let lat : Decimal?
    
    public required init?(json: JSON) {
        self.lon = "lon" <~~ json
        self.lat = "lat" <~~ json
    }
}

public class WeatherItemResponse : Decodable {
    let id : Decimal?
    let main : String?
    let description : String?
    let icon : String?
    
    public required init?(json:JSON) {
        self.id = "id" <~~ json
        self.main = "main" <~~ json
        self.description = "description" <~~ json
        self.icon = "icon" <~~ json
    }
}

public class MainResponse :Decodable {
    let temp : Decimal?
    let pressure : Decimal?
    let humidity : Decimal?
    let tempMin : Decimal?
    let tempMax : Decimal?
    
    public required init?(json:JSON) {
        self.temp = "temp" <~~ json
        self.pressure = "pressure" <~~ json
        self.humidity = "humidity" <~~ json
        self.tempMin = "tempMin" <~~ json
        self.tempMax = "tempMax" <~~ json
    }
}

public class WindResponse : Decodable {
    let speed : Decimal?
    let deg : Decimal?
    
    public required init?(json:JSON) {
        self.speed = "speed" <~~ json
        self.deg = "deg" <~~ json
    }
}

public class CloudsResponse : Decodable {
    let all : Decimal?
    
    public required init?(json: JSON){
        self.all = "all" <~~ json
    }
}

public class SysResponse : Decodable {
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
}
