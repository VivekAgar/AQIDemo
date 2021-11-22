//
//  CardView.swift
//  aqi
//
//  Created by vivek on 22/11/21.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView{
    
    @IBInspectable var cornorRadius: CGFloat = 0
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    @IBInspectable var shadowOffsetHeight: CGFloat = 1
    @IBInspectable var shadowOpacity: Float = 0.2
    
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornorRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornorRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowColor = shadowColor.cgColor
    }
    
    
    
}
