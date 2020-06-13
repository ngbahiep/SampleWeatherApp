//
//  WeatherViewModel.swift
//  SampleWeatherApp
//
//  Created by Hiep Nguyen on 12/06/2020.
//  Copyright © 2020 Hiep Nguyen. All rights reserved.
//

import Foundation

public class WeatherViewModel {
    
    private let weatherItem: List
    
    public init(_ weatherItem: List) {
        self.weatherItem = weatherItem
    }
    
    var date: String {
        let date = Date(timeIntervalSince1970: TimeInterval(weatherItem.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE, dd MMM yyyy"
        return "Date: " + dateFormatter.string(from: date)
    }
    
    var averageTemp: String {
        let avarageTemp = (weatherItem.temp.max + weatherItem.temp.min) / 2
        return "Avarage Temperature: " + String(Int(avarageTemp)) + "°C"
    }
    
    var presssure: String {
        return "Pressure: " + String(weatherItem.pressure)
    }
    
    var humidity: String {
        return "Humidity: " + String(weatherItem.humidity)
    }
    
    var description: String {
        return "Description: " + weatherItem.weather[0].weatherDescription
    }
    
    public func configure(_ view: WeatherTableViewCell) {
        view.lblDate.text = date
        view.lblAvgTemp.text = averageTemp
        view.lblPressure.text = presssure
        view.lblHumidity.text = humidity
        view.lblDescription.text = description
    }

}
