//
//  ViewController.swift
//  SampleWeatherApp
//
//  Created by Hiep Nguyen on 11/06/2020.
//  Copyright © 2020 Hiep Nguyen. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if NetworkReachabilityManager()?.isReachable ?? false {
            print("Got internet connection")
            AF.request("https://api.openweathermap.org/data/2.5/forecast/daily?q=saigon&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric").responseDecodable( of: Weather.self) { response in
                
//                print(response.description)
                
                guard let weather = response.value else { return }
                self.weather = weather
                
                self.tableView.reloadData()
                
                print(weather)
                
            }
        } else {
            print("No internet connection")
        }
    }

}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weather?.cnt ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherTableViewCell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if let weatherItem = weather?.list[indexPath.row] {
            let weatherViewModel = WeatherViewModel(weatherItem)
            weatherViewModel.configure(cell)
        }
        
        
        return cell
    }
    
}
