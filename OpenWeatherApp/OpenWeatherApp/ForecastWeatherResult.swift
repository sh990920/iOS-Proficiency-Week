//
//  ForecastWeatherResult.swift
//  OpenWeatherApp
//
//  Created by 박승환 on 7/10/24.
//

import Foundation

struct ForecastWeatherResult: Codable {
    let list: [ForecastWeather]
}

struct ForecastWeather: Codable {
    let main: WeatherMain
    let dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case dtTxt = "dt_txt"
    }
}
