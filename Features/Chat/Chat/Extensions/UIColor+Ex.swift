//
//  UIColor+Ex.swift
//  Chat
//
//  Created by 서정덕 on 12/5/23.
//

import UIKit

extension UIColor {
    /// UIColor(red: 111, green: 222, blue: 333)
    convenience init(red: Int, green: Int, blue: Int) {
            self.init(
                red: CGFloat(red) / 255.0,
                green: CGFloat(green) / 255.0,
                blue: CGFloat(blue) / 255.0, 
                alpha: 1.0
            )
    }
    
    /// UIColor(hex: "#3eb489") 실패시 #FF0000으로 초기화
    convenience init(hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            self.init(
                red: 255 / 255.0,
                green: 0 / 255.0,
                blue: 0 / 255.0,
                alpha: 1.0
            )
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
