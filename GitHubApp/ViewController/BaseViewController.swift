//
//  BaseViewController.swift
//  GitHubApp
//
//  Created by Ric. on 2020/5/27.
//  Copyright © 2020 Ric. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var shouldAutorotate: Bool {
        return false
    }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension BaseViewController {
    
    func showErrorAlert(with message: String?) {
        let alert = UIAlertController(title: "There's Some Trouble!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
