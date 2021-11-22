//
//  Utility.swift
//  aqi
//
//  Created by vivek on 23/11/21.
//

import Foundation
import UIKit

enum AQILevel{
    
    case good
    case satisfactory
    case modrate
    case poor
    case veryPoor
    case severe
}

extension AQILevel {
    var value: UIColor {
        get {
            switch self {
            case .good:
                return UIColor(red: 105/255, green: 166/255, blue: 90/255, alpha: 1.0)
            case .satisfactory:
                return UIColor(red: 170/255, green: 199/255, blue: 101/255, alpha: 1.0)
            case .modrate:
                return UIColor(red: 254/255, green: 248/255, blue: 95/255, alpha: 1.0)
            case .poor:
                return UIColor(red: 230/255, green: 160/255, blue: 74/255, alpha: 1.0)
            case .veryPoor:
                return UIColor(red: 215/255, green: 77/255, blue: 63/255, alpha: 1.0)
            case .severe:
                return UIColor(red: 160/255, green: 56/255, blue: 44/255, alpha: 1.0)
            }
        }
    }
}

extension AQILevel {
    var title: String {
        get {
            switch self {
            case .good:
                return "Good"
            case .satisfactory:
                return "Satisfactory"
            case .modrate:
                return "Modrate"
            case .poor:
                return "Poor"
            case .veryPoor:
                return "Very Poor"
            case .severe:
                return "Severe"
            }
        }
    }
}

extension AQILevel {
    var description: String {
        get {
            switch self {
            case .good:
                return "Air quality is considered satisfactory, and air pollution poses little or no risk"
            case .satisfactory:
                return "Air quality is acceptable; however, for some pollutants there may be a moderate health concern for people who are unusually sensitive to air pollution."
            case .modrate:
                return "Members of sensitive groups may experience health effects. The general public is not likely to be affected."
            case .poor:
                return "Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects"
            case .veryPoor:
                return "Health warnings of emergency conditions. The entire population is more likely to be affected."
            case .severe:
                return "Health alert: everyone may experience more serious health effects"
            }
        }
    }
}

extension Float {
    
    func afficherUnFloat() -> String {
        let text : NSNumber = self as NSNumber
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = .current
        numberFormatter.groupingSeparator = ""
        numberFormatter.maximumFractionDigits = 2 // your choice
        numberFormatter.maximumIntegerDigits = 6 // your choice

        let result = numberFormatter.string(from: text) ?? ""
            return result
    }
    
    
}

extension Int {
    func format(f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}


