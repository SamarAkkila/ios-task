//
//  Extension.swift
//  Vero-TaskApp
//
//  Created by MacBook on 28/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    // OUTPUT 1
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        
    }
    
}

extension String {
    
    func trimWhiteSpace() -> String {
        let string = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return string
    }
    
    func getUIColor() -> UIColor {
        return UIColor.init(hexString: self)
    }
    
    var isEmptyStr : Bool {
        return self.trimWhiteSpace().isEmpty
    }
    

}


extension UIView {
    
    //Start Rotating view
    func startRotating(duration: Double = 1) {
        let kAnimationKey = "rotation"
        
        if self.layer.animation(forKey: kAnimationKey) == nil {
            let animate = CABasicAnimation(keyPath: "transform.rotation")
            animate.duration = duration
            animate.repeatCount = Float.infinity
            
            animate.fromValue = Float(Double.pi * -2.0)
            animate.toValue = 0.0
            self.layer.add(animate, forKey: kAnimationKey)
        }
    }
    
    //Stop rotating view
    func stopRotating() {
        let kAnimationKey = "rotation"
        
        DispatchQueue.main.async {
            if self.layer.animation(forKey: kAnimationKey) != nil {
                self.layer.removeAnimation(forKey: kAnimationKey)
            }
        }
    }
    
}

extension UIColor {
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    
}
