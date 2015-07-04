//
//  GradientExtension.swift
//  swift_test
//
//  Created by a1673450 on 9/06/2015.
//  Copyright (c) 2015 adelaide. All rights reserved.
//

import Foundation
import UIKit

extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
        var layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [UIColor(rgba: "#DAD299").CGColor, UIColor(rgba: "#B0DAB9").CGColor]
        return layer
    }
}