//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let titleTopMargin: CGFloat = 4
        static let titleLeftMargin: CGFloat = 30
        static let titleRightMargin: CGFloat = 50
        static let readIconHeight: CGFloat = 16
        static let readIconLeftMargin: CGFloat = 10
        static let starIconSize: CGFloat = 14
        static let starIconLeftMargin: CGFloat = 7
    }
    
    // MARK: - Properties
    
    private var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private var readIConView: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 8
        return container
    }()
    
    private let starImageBtn: UIButton = {
        let iconBtn = UIButton()
        iconBtn.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        iconBtn.setImage(UIImage(systemName: "star.fill")?.withTintColor(.yellow, renderingMode: .alwaysOriginal), for: .selected)
        iconBtn.translatesAutoresizingMaskIntoConstraints = false
        iconBtn.isHidden = true
        return iconBtn
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private var dividerView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Private function
    
    private func commonInit() {
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate(ConstraintUtil.pinAllSides(of: containerView, to: contentView))
        
        contentView.addSubview(dividerView)
        NSLayoutConstraint.activate([ConstraintUtil.pinRightOfView(dividerView,
                                                                   toRightOfView: containerView, withMargin:
                                                                    -Constants.readIconLeftMargin),
                                     ConstraintUtil.pinBottomOfView(dividerView, toBottomOfView: containerView),
                                     ConstraintUtil.pinLeftOfView(dividerView, toLeftOfView: containerView, withMargin: Constants.readIconLeftMargin),
                                     ConstraintUtil.setHeight(1, toView: dividerView)
                                    ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinRightOfView(titleLabel,
                                                                   toRightOfView: containerView, withMargin:
                                                                    Constants.titleRightMargin),
                                     ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: containerView,
                                                                 withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.pinBottomOfView(titleLabel, toBottomOfView: containerView, withMargin: -Constants.titleTopMargin),
                                     ConstraintUtil.pinLeftOfView(titleLabel, toLeftOfView: containerView, withMargin: Constants.titleLeftMargin)
                                    ])
        
        contentView.addSubview(readIConView)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(readIConView, inContainingView: containerView),
                                     ConstraintUtil.setHeight(Constants.readIconHeight, toView: readIConView),
                                     ConstraintUtil.pinLeftOfView(readIConView, toLeftOfView: containerView, withMargin: Constants.readIconLeftMargin)
        ])
        
        contentView.addSubview(starImageBtn)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(starImageBtn, inContainingView: containerView),
                                     ConstraintUtil.setHeight(Constants.starIconSize, toView: starImageBtn),
                                     ConstraintUtil.setWidth(starImageBtn, constant: Constants.starIconSize),
                                     ConstraintUtil.pinLeftOfView(starImageBtn, toLeftOfView: containerView, withMargin: Constants.starIconLeftMargin)
        ])
    }

}
