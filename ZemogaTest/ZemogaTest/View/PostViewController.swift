//
//  PostViewController.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import UIKit

class PostViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title: String = "Description"
        static let userTitle: String = "User"
        static let commentsTitle: String = "Comments"
        
        static let titleLeftMargin: CGFloat = 10
        static let titleTopMargin: CGFloat = 10
        static let descriptionTopMargin: CGFloat = 4
        static let userInfoViewHeight: CGFloat = 100
        
        static let postCellIdentifier: String = PostTableViewCell.reuseIdentifier
    }
    
    // MARK: - Properties
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = Constants.title
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 6
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()
    
    private var userInfoView: UserInfoView = {
        let userView = UserInfoView(offerAmount: 1)
        userView.translatesAutoresizingMaskIntoConstraints = false
        return userView
    }()
    
   
    
    var tableView: UITableView = {
        let tableView = UITableView.newAutolayoutTableView()
//        view.dataSource = self
//        view.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension // valor CGFloat
//        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViews()
    }
    
    func addChildViews() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(titleLabel,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(titleLabel,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: view, withMargin: Constants.titleTopMargin)
        ])
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(descriptionLabel,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(descriptionLabel,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(descriptionLabel, toBottomOfView: titleLabel, withMargin: Constants.descriptionTopMargin)
        ])
        
        
        
        view.addSubview(userInfoView)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(userInfoView,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(userInfoView,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(userInfoView, toBottomOfView: descriptionLabel, withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.setHeight(Constants.userInfoViewHeight, toView: userInfoView)
        ])
       
        view.addSubview(tableView)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(tableView,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(tableView,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(tableView, toBottomOfView: userInfoView, withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.pinBottomOfView(tableView, toBottomOfView: view)
        ])
        
        
                tableView.register(PostTableViewCell.self, forCellReuseIdentifier: Constants.postCellIdentifier)
        //
        //        NSLayoutConstraint.activate(ConstraintUtil.pinAllSides(of: customTableView, to: container))
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
