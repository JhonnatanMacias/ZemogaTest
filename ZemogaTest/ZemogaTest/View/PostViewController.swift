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
    
    // MARK: - Properties
    
    @IBOutlet private var postSegmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.pageTitle
        
        setNeedsStatusBarAppearanceUpdate()
        setupSegmentedControlStyle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    // MARK: - Private Functions
    
    private func setupSegmentedControlStyle() {
        if #available(iOS 13.0, *) {
           postSegmentedControl.selectedSegmentTintColor = UIColor.baseGreenColor()
            postSegmentedControl.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.5)
        } else {
            postSegmentedControl.tintColor = UIColor.baseGreenColor()
        }
       
        postSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        postSegmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.baseGreenColor()], for: .normal)
        postSegmentedControl.layer.borderWidth = 1.0
        postSegmentedControl.layer.borderColor = UIColor.baseGreenColor().cgColor
        postSegmentedControl.layer.masksToBounds = true
    }
    
    // MARK: - Internal Functions
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
    }
    
    @IBAction func handleSegmentChange(_ sender: Any) {
   
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
