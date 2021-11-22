//
//  AQITableViewCell.swift
//  aqi
//
//  Created by vivek on 21/11/21.
//

import Foundation
import UIKit

class AQITableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var aQIValueLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var aQIGradientView: AQIGradientView!
    @IBAction func onViewMoreButton(_ sender: Any) {
    
        
        
        
        
    }
    
    
    
    
    
}

//extension AQITableViewCell {
//
//    var isDetailViewHidden: Bool {
//        return detailView.isHidden
//    }
//
//    func showDetailView() {
//        detailView.isHidden = false
//    }
//
//    func hideDetailView() {
//        detailView.isHidden = true
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        if isDetailViewHidden, selected {
//            showDetailView()
//        } else {
//            hideDetailView()
//        }
//    }
//}
