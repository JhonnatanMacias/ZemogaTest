//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    // MARK: - Constants
    
    private enum Constants {
        static let titleTopMargin: CGFloat = 4
        static let titleLeftMargin: CGFloat = 10
        static let titleRightMargin: CGFloat = 10
    }
    
    // MARK: - Properties
    
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
        
        contentView.addSubview(dividerView)
        NSLayoutConstraint.activate([ConstraintUtil.pinRightOfView(dividerView,
                                                                   toRightOfView: contentView, withMargin:
                                                                    -Constants.titleRightMargin),
                                     ConstraintUtil.pinBottomOfView(dividerView, toBottomOfView: contentView),
                                     ConstraintUtil.pinLeftOfView(dividerView, toLeftOfView: contentView, withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.setHeight(1, toView: dividerView)
                                    ])
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinRightOfView(titleLabel,
                                                                   toRightOfView: contentView, withMargin:
                                                                    Constants.titleRightMargin),
                                     ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: contentView,
                                                                 withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.pinBottomOfView(titleLabel, toBottomOfView: contentView, withMargin: -Constants.titleTopMargin),
                                     ConstraintUtil.pinLeftOfView(titleLabel, toLeftOfView: contentView, withMargin: Constants.titleLeftMargin)
                                    ])
        
        
    }
}
