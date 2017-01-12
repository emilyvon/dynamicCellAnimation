//
//  WeekviewTableViewCell.swift
//  testing-hero
//
//  Created by Mengying Feng on 12/1/17.
//  Copyright © 2017 iEmRollin. All rights reserved.
//

import UIKit

class WeekviewTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var taskNoLabel: UILabel!
    @IBOutlet weak var weekdayStrLabel: UILabel!
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var icon1ImageView: UIImageView!
    @IBOutlet weak var icon2ImageView: UIImageView!
    @IBOutlet weak var icon3ImageView: UIImageView!
    @IBOutlet weak var description1Label: UILabel!
    @IBOutlet weak var description2Label: UILabel!
    @IBOutlet weak var description3Label: UILabel!
    @IBOutlet weak var weekendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(weekdayNo: Int, currentActiveTaskNo: Int, taskNo: Int) {
        
        print("weekdayNo: \(weekdayNo), currentActiveTaskNo: \(currentActiveTaskNo)")
        
        weekdayStrLabel.text = Helper.shared.weekdayConverter(weekday: weekdayNo)
        taskNoLabel.text = "\(taskNo+1)"
        
        setupCommonUI(isWeekend: weekdayNo == 7 || weekdayNo == 1 ? true : false)
        
        if weekdayNo == 7 || weekdayNo == 1 {
            
            topContainerView.backgroundColor = UIColor.white
            bottomContainerView.backgroundColor = UIColor.white
            
        } else {
            
            if weekdayNo == currentActiveTaskNo {
                
                topContainerView.backgroundColor = UIColor(red: 44/255, green: 171/255, blue: 213/255, alpha: 0.8)
                bottomContainerView.backgroundColor = UIColor(red: 44/255, green: 171/255, blue: 213/255, alpha: 0.8)
                
                
            } else {
                topContainerView.backgroundColor = UIColor(red: 217/255, green: 229/255, blue: 234/255, alpha: 1.0)
                bottomContainerView.backgroundColor = UIColor(red: 217/255, green: 229/255, blue: 234/255, alpha: 1.0)
            }
        }
        
    }
    
    
    func setupCommonUI(isWeekend: Bool) {
        contentView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0)
        
        taskNoLabel.isHidden = isWeekend
        icon1ImageView.isHidden = isWeekend
        icon2ImageView.isHidden = isWeekend
        icon3ImageView.isHidden = isWeekend
        description1Label.isHidden = isWeekend
        description2Label.isHidden = isWeekend
        description3Label.isHidden = isWeekend
        
        weekendImageView.isHidden = !isWeekend
    }
    
    
}
