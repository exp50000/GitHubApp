//
//  UINavigationController+Extension.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/27.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var shouldAutorotate : Bool {
        guard let visibleViewController = self.visibleViewController else {
            return super.shouldAutorotate
        }
        
        return visibleViewController.shouldAutorotate
    }
    
    open override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        guard let visibleViewController = self.visibleViewController else {
            return super.supportedInterfaceOrientations
        }
        
        return visibleViewController.supportedInterfaceOrientations
    }
    
    open override var preferredInterfaceOrientationForPresentation : UIInterfaceOrientation {
        guard let visibleViewController = self.visibleViewController else {
            return super.preferredInterfaceOrientationForPresentation
        }
        
        return visibleViewController.preferredInterfaceOrientationForPresentation
    }
}
