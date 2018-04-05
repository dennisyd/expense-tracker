//
//  AmountIndicatorView.swift
//  ExpenseTracker
//
//  Created by Peter Alt on 4/5/18.
//  Copyright © 2018 Peter Alt. All rights reserved.
//

import UIKit

class AmountIndicatorView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mask(viewToMask: self, maskRect: CGRect(x: 0, y: 0, width: 5, height: 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mask(viewToMask: self, maskRect: CGRect(x: 0, y: 0, width: 5, height: 5))
//        fatalError("init(coder:) has not been implemented")
    }
    
    func mask(viewToMask: UIView, maskRect: CGRect) {
        let maskLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath()
        
        bezierPath.move(to: CGPoint(x: 0, y: 0))
        bezierPath.addLine(to: CGPoint(x: self.bounds.width, y: 0))
        bezierPath.addLine(to: CGPoint(x: 0, y: self.bounds.height))
        bezierPath.addLine(to: CGPoint(x: 0, y: 0))
        bezierPath.close()
        
        maskLayer.path = bezierPath.cgPath
        
        viewToMask.layer.mask = maskLayer;
    }
        
    func setValue(value: Double) {
        if value < 25 {
            self.backgroundColor = UIColor.green
        }
        if value >= 25 && value < 100 {
            self.backgroundColor = UIColor.orange
        }
        if value >= 100 {
            self.backgroundColor = UIColor.red
        }
    }

}
