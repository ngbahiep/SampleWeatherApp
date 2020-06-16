//
//  Weather.swift
//  SampleWeatherApp
//
//  Created by Hiep Nguyen on 12/06/2020.
//  Copyright © 2020 Hiep Nguyen. All rights reserved.
//

import Foundation

// MARK: - Weather
class Weather: Codable {
    let city: City
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherItem]

    init(city: City, cod: String, message: Double, cnt: Int, list: [WeatherItem]) {
        self.city = city
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
    }
}

// MARK: - City
class City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int

    init(id: Int, name: String, coord: Coord, country: String, population: Int, timezone: Int) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
        self.timezone = timezone
    }
}

// MARK: - Coord
class Coord: Codable {
    let lon, lat: Double

    init(lon: Double, lat: Double) {
        self.lon = lon
        self.lat = lat
    }
}

// MARK: - List
public class WeatherItem: Codable {
    let dt, sunrise, sunset: Int
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure, humidity: Int
    let weather: [WeatherElement]
    let speed: Double
    let deg, clouds: Int
    let rain: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity, weather, speed, deg, clouds, rain
    }

    init(dt: Int, sunrise: Int, sunset: Int, temp: Temp, feelsLike: FeelsLike, pressure: Int, humidity: Int, weather: [WeatherElement], speed: Double, deg: Int, clouds: Int, rain: Double?) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.temp = temp
        self.feelsLike = feelsLike
        self.pressure = pressure
        self.humidity = humidity
        self.weather = weather
        self.speed = speed
        self.deg = deg
        self.clouds = clouds
        self.rain = rain
    }
}

// MARK: - FeelsLike
class FeelsLike: Codable {
    let day, night, eve, morn: Double

    init(day: Double, night: Double, eve: Double, morn: Double) {
        self.day = day
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}

// MARK: - Temp
class Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double

    init(day: Double, min: Double, max: Double, night: Double, eve: Double, morn: Double) {
        self.day = day
        self.min = min
        self.max = max
        self.night = night
        self.eve = eve
        self.morn = morn
    }
}

// MARK: - WeatherElement
class WeatherElement: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }

    init(id: Int, main: String, weatherDescription: String, icon: String) {
        self.id = id
        self.main = main
        self.weatherDescription = weatherDescription
        self.icon = icon
    }
}
