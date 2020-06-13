//
//  SampleWeatherAppTests.swift
//  SampleWeatherAppTests
//
//  Created by Hiep Nguyen on 11/06/2020.
//  Copyright © 2020 Hiep Nguyen. All rights reserved.
//

import XCTest
@testable import SampleWeatherApp

class SampleWeatherAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testViewModelDate() {
        
        let weatherItem = generateWeatherItem()
        
        let viewModel = WeatherViewModel(weatherItem)
        
        let date = Date(timeIntervalSince1970: TimeInterval(weatherItem.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE, dd MMM yyyy"
        let strExpected = "Date: " + dateFormatter.string(from: date)
        
        XCTAssertEqual(strExpected, viewModel.date)
    }
    
    func testViewModelAverageTemp() {
        
        let weatherItem = generateWeatherItem()
        let avarageTemp = (weatherItem.temp.max + weatherItem.temp.min) / 2
        let strExpected = "Avarage Temperature: " + String(Int(avarageTemp)) + "°C"
        
        let viewModel = WeatherViewModel(weatherItem)
        
        XCTAssertEqual(strExpected, viewModel.averageTemp)
    }
    
    func testViewModelPressure() {
        
        let weatherItem = generateWeatherItem()
        let strExpected = "Pressure: " + String(weatherItem.pressure)
        
        let viewModel = WeatherViewModel(weatherItem)
        
        XCTAssertEqual(strExpected, viewModel.presssure)
    }
    
    func testViewModelHumidity() {
        
        let weatherItem = generateWeatherItem()
        let strExpected = "Humidity: " + String(weatherItem.humidity)
        
        let viewModel = WeatherViewModel(weatherItem)
        
        XCTAssertEqual(strExpected, viewModel.humidity)
    }
    
    func testViewModelDescription() {
        
        let weatherItem = generateWeatherItem()
        let strExpected = "Description: " + weatherItem.weather[0].weatherDescription
        
        let viewModel = WeatherViewModel(weatherItem)
        
        XCTAssertEqual(strExpected, viewModel.description)
    }
    
    func generateWeatherItem() -> List {
        let temp = Temp(day: 32, min: 27.14, max: 32, night: 27.14, eve: 29.97, morn: 32)
        let feels_like = FeelsLike(day: 37.12, night: 30.5, eve: 34.43, morn: 37.12)
        let weatherElement = WeatherElement(id: 502, main: "Rain", weatherDescription: "heavy intensity rain", icon: "10d")
        
        let weatherItem = List(dt: 1592020800, sunrise: 1592001057, sunset: 1592046961, temp: temp, feelsLike: feels_like, pressure: 1005, humidity: 66, weather: [weatherElement], speed: 1.71, deg: 248, clouds: 75, rain: 18.74)
        
        return weatherItem
    }

}
