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
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var weather: Weather?
    var request: Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure UISearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Add search controller to navigation item
        navigationItem.searchController = searchController
        
        // configure UITableView
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func searchWeather(city: String, completion: @escaping (Weather?) -> Void) {
        print("searchWeather: \(city)")
        if NetworkReachabilityManager()?.isReachable ?? false {
            print("Got internet connection")
            
            let strUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&cnt=7&appid=60c6fbeb4b93ac653c492ba806fc346d&units=metric"
            
            print("strURL: \(strUrl)")
            
            guard let url = URL(string: strUrl) else { return }
            var req = URLRequest(url: url)
            req.cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
            
            // Invalidate previous request
            if let request = request {
                request.cancel()
            }
            
            request = AF.request(req)
                .validate()
                .responseDecodable( of: Weather.self) { response in
                
                print(response.description)
                
                if (nil != response.error) {
                    print("ERROR: \(String(describing: response.error))")
                    completion(nil)
                    return
                }
                
                guard let weather = response.value else {
                    completion(nil)
                    return
                }
                    
                completion(weather)
                
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

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let strSearch = searchController.searchBar.text else {
            return
        }
        
        if strSearch.count >= 3 {
            // start progress
            Prog.start(in: self.tableView, .activityIndicator)
            
            searchWeather(city: strSearch) { (weather) in
                print("Reload data ...")
                self.weather = weather
                self.tableView.reloadData()
                
                // dismiss progress
                Prog.dismiss(in: self.tableView)
            }   
        }
    }
}
