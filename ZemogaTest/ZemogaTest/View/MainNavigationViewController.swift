//
//  MainNavigationViewController.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    // MARK: - Properties
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return UIStatusBarStyle.lightContent
        } else {
            return UIStatusBarStyle.default
        }
    }

    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        // Do any additional setup after loading the view.
    }
    

}
