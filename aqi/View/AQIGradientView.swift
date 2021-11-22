//
//  AQIGradientView.swift
//  aqi
//
//  Created by vivek on 22/11/21.
//

import Foundation
import UIKit
import Starscream

class AQIGradientView: UIView{
    
    
    private var knobView: UIView = UIView()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.autoresizingMask =  [.flexibleRightMargin, .flexibleLeftMargin]
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.purple
        let gradientLayer:CAGradientLayer = CAGradientLayer()
         gradientLayer.frame.size = self.frame.size
         gradientLayer.colors =
        [AQILevel.good.value.cgColor, AQILevel.satisfactory.value.cgColor, AQILevel.modrate.value.cgColor, AQILevel.poor.value.cgColor, AQILevel.veryPoor.value.cgColor, AQILevel.severe.value.cgColor]
        let start : CGPoint = CGPoint(x: 0.0, y: 1.0)
        let end : CGPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.locations = [0.0 ,0.10, 0.20, 0.40, 0.60, 0.80, 1.0]
        //Use diffrent colors
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.knobView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        self.knobView.backgroundColor = UIColor.white
        self.knobView.layer.cornerRadius = self.frame.height * 0.5
        self.addSubview(knobView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        
        
        
        self.autoresizingMask =  [.flexibleRightMargin, .flexibleLeftMargin]
        self.layer.cornerRadius = 20
        self.backgroundColor = UIColor.purple
        let gradientLayer:CAGradientLayer = CAGradientLayer()
         gradientLayer.frame.size = self.frame.size
         gradientLayer.colors =
        [AQILevel.good.value.cgColor, AQILevel.satisfactory.value.cgColor, AQILevel.modrate.value.cgColor, AQILevel.poor.value.cgColor, AQILevel.veryPoor.value.cgColor, AQILevel.severe.value.cgColor]
        let start : CGPoint = CGPoint(x: 0.0, y: 1.0)
        let end : CGPoint = CGPoint(x: 1.0, y: 1.0)
        
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.locations = [0.0 ,0.10, 0.20, 0.40, 0.60, 0.80, 1.0]
        self.layer.addSublayer(gradientLayer)
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.knobView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.height, height: self.frame.height))
        self.knobView.backgroundColor = UIColor.white
        self.knobView.layer.cornerRadius = self.frame.height * 0.5
        self.addSubview(knobView)

        }
    
    func configureAQIGradientViewFor( aQIValue: Double){
        self.knobView.frame.origin.x = self.frame.width * CGFloat( aQIValue / 500.0)
    }
    
    
}
