//
//  UserInfoView.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import Foundation
import UIKit

class UserInfoView: UIView {
    
    // MARK: - Constants
    
    private enum Constants {
        static let userTitle: String = "User"
        
        static let titleTopMargin: CGFloat = 10
        static let stackViewTopMargin: CGFloat = 4
        static let stackViewHeight: CGFloat = 80
        static let userLabelHeight: CGFloat = 21
        
        static let nameTitle = "Name %@"
        static let emailTitle = "Email %@"
        static let phoneTitle = "Phone %@"
        static let webSiteTitle = "WebSite %@"
    }
    
    // MARK: - Private Properties
    
    private var stackView: UIStackView = {
        let stackView = UIStackView.newAutolayoutStackView()
        return stackView
    }()
    
    private var userLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = Constants.userTitle
        return label
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .justified
        label.textColor = .black
        return label
    }()
    
    private var phoneLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private var webSiteLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private var container: UIView!
    private var titleLabel: UILabel!
    private var indicatorPointingImageView: UIImageView!
    private var closeButton: UIButton!

    var closeButtonAction: (() -> Void)?

    // MARK: - Initializer

    convenience init(offerAmount: Int) {
        self.init(frame: CGRect.zero)
        setupView(offerAmount: offerAmount)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Private Methods
    
    private func setupView(offerAmount: Int) {
        backgroundColor = .white
        
        addSubview(userLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(userLabel,
                                                                  toLeftOfView: self),
                                     ConstraintUtil.pinRightOfView(userLabel,
                                                                   toRightOfView: self),
                                     ConstraintUtil.pinTopOfView(userLabel, toTopOfView: self, withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.setHeight(Constants.userLabelHeight, toView: userLabel)
                                     
        ])
        
        addSubview(stackView)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(stackView,
                                                                  toLeftOfView: self),
                                     ConstraintUtil.pinRightOfView(stackView,
                                                                   toRightOfView: self),
                                     ConstraintUtil.pinTopOfView(stackView, toBottomOfView: userLabel, withMargin: Constants.stackViewTopMargin),
                                     ConstraintUtil.setHeight(Constants.stackViewHeight, toView: stackView)
        ])
        
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(webSiteLabel)

    }
    
    func updateInfo(user: User) {
        nameLabel.text = String(format: Constants.nameTitle, ": \(user.name)")
        nameLabel.sizeToFit()
        
        emailLabel.text = String(format: Constants.emailTitle, ": \(user.email)")
        emailLabel.sizeToFit()
        
        phoneLabel.text = String(format: Constants.phoneTitle, ": \(user.phone)")
        phoneLabel.sizeToFit()
        
        webSiteLabel.text = String(format: Constants.webSiteTitle, ": \(user.webSite)")
        webSiteLabel.sizeToFit()
    }
    
}
