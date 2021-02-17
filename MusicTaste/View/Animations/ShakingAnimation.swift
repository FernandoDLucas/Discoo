//
//  ShakingAnimation.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 12/02/21.
//

import UIKit

class Animations {
    static func shakingAnimation(on onView: UIView) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.1
        animation.repeatCount = .infinity
        animation.beginTime = CFTimeInterval(Float.random(in: 0...2))
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: onView.center.x - 1, y: onView.center.y + 1))
        animation.toValue = NSValue(cgPoint: CGPoint(x: onView.center.x + 1, y: onView.center.y - 1))
        onView.layer.add(animation, forKey: "position")
    }
}
