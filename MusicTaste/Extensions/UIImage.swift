//
//  UIImage.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 12/02/21.
//

import UIKit

extension UIImage {
    func fixOrientation(image: UIImage) -> UIImage? {
        if image.imageOrientation == .up {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.width)
        image.draw(in: rect)

        let normalizeImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return normalizeImg
    }
}
