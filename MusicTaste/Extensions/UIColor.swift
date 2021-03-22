//
//  UIColor.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 22/03/21.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static let calmPurple = UIColor.rgb(red: 236, green: 179, blue: 243)
    static let calmBlue = UIColor.rgb(red: 177, green: 211, blue: 233)
    static let calmPink = UIColor.rgb(red: 255.0, green: 154.0, blue: 230.0)
}
