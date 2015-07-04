//
//  NavController.swift
//  swift_test
//
//  Created by a1673450 on 9/06/2015.
//  Copyright (c) 2015 adelaide. All rights reserved.
//

import Foundation
import UIKit

class NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.translucent = false
        self.navigationBar.tintColor = UIColor.whiteColor()
        let fontDictionary = [ NSForegroundColorAttributeName:UIColor.whiteColor() ]
        self.navigationBar.titleTextAttributes = fontDictionary
        self.navigationBar.setBackgroundImage(imageLayerForGradientBackground(), forBarMetrics: UIBarMetrics.Default)
    }
    
    private func imageLayerForGradientBackground() -> UIImage {
        
        var updatedFrame = self.navigationBar.bounds
        // take into account the status bar
        updatedFrame.size.height += 20
        var layer = CAGradientLayer.gradientLayerForBounds(updatedFrame)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}