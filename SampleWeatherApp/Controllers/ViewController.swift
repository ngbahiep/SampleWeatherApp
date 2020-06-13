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
    
    let APP_ID = "60c6fbeb4b93ac653c492ba806fc346d"
    let UNITS = "metric"
    let DEFAULT_COUNT = "7"
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var weather: Weather?
    var request: Request?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("app_name", comment: "")
        
        // configure UISearchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.accessibilityIdentifier = "searchBar"
        searchController.searchBar.isAccessibilityElement = true
        searchController.searchBar.accessibilityTraits = .searchField
        searchController.searchBar.accessibilityLabel = NSLocalizedString("search", comment: "")
        
        // Add search controller to navigation item
        navigationItem.searchController = searchController
        
        // configure UITableView
        tableView.dataSource = self
    }
    
    func searchWeather(city: String, completion: @escaping (Weather?) -> Void) {
        print("searchWeather: \(city)")
        if NetworkReachabilityManager()?.isReachable ?? false {
            print("Got internet connection")
            
            let strUrl = "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city)&cnt=\(DEFAULT_COUNT)&appid=\(APP_ID)&units=\(UNITS)"
            
            print("strURL: \(strUrl)")
            
            guard let url = URL(string: strUrl) else { return }
            var req = URLRequest(url: url)
            req.cachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
            
            // Cancel previous request
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
            }
            
        } else {
            print("No internet connection")
        }
    }

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
