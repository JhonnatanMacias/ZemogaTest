//
//  PostViewController.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let pageTitle: String = "Post"
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.pageTitle
        
        setNeedsStatusBarAppearanceUpdate()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    

    // MARK: - Internal Functions
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
