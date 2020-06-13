//
//  WeatherTableViewCell.swift
//  SampleWeatherApp
//
//  Created by Hiep Nguyen on 11/06/2020.
//  Copyright © 2020 Hiep Nguyen. All rights reserved.
//

import UIKit

public class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAvgTemp: UILabel!
    @IBOutlet weak var lblPressure: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        // Disability Supports - Dynamic text size
        lblDate.font = UIFont.preferredFont(forTextStyle: .body)
        lblDate.adjustsFontForContentSizeCategory = true
        
        lblAvgTemp.font = UIFont.preferredFont(forTextStyle: .body)
        lblAvgTemp.adjustsFontForContentSizeCategory = true
        
        lblPressure.font = UIFont.preferredFont(forTextStyle: .body)
        lblPressure.adjustsFontForContentSizeCategory = true
        
        lblHumidity.font = UIFont.preferredFont(forTextStyle: .body)
        lblHumidity.adjustsFontForContentSizeCategory = true
        
        lblDescription.font = UIFont.preferredFont(forTextStyle: .body)
        lblDescription.adjustsFontForContentSizeCategory = true
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
