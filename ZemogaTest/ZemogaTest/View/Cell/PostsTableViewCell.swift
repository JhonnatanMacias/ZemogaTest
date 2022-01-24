//
//  PostTableViewCell.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import UIKit

//protocol PostsTableViewCell: AnyObject {
////    func se
//}

class PostsTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let titleTopMargin: CGFloat = 10
        static let titleLeftMargin: CGFloat = 40
        static let titleRightMargin: CGFloat = 50
        static let readIconHeight: CGFloat = 14
        static let readIconLeftMargin: CGFloat = 12
        static let starIconSize: CGFloat = 22
        static let starIconLeftMargin: CGFloat = 10
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
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 7
        container.isHidden = true
        return container
    }()
    
    private let starImageBtn: UIButton = {
        let iconBtn = UIButton()
        iconBtn.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        iconBtn.setImage(UIImage(systemName: "star.fill")?.withTintColor(UIColor.favoriteButtonColor(), renderingMode: .alwaysOriginal), for: .selected)
        iconBtn.translatesAutoresizingMaskIntoConstraints = false
        iconBtn.isHidden = true
        return iconBtn
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 5
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = UIColor.mainGrayDarkFontColor()
        return label
    }()
    
    private var dividerView: UIView = {
        let container = UIView()
        container.backgroundColor = .lightGray
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    var viewModel: PostCellViewModelProtocol! {
        didSet {
            viewModel.message.bindAndFire { [weak self] message in
                guard let self = self else {
                    return
                }
                
                self.titleLabel.text = message
                self.titleLabel.sizeToFit()
            }
            
            viewModel.read.bindAndFire { [weak self] isRead in
                guard let self = self else {
                    return
                }
                
                self.readIConView.isHidden = isRead
            }
            
            viewModel.postDetail.bindAndFire { [weak self] detail in
                guard let self = self else {
                    return
                }
                
                self.starImageBtn.isHidden = !detail.isFavorited
                self.starImageBtn.isSelected = detail.isFavorited
            }
            
            viewModel.postDetailViewModel.bindAndFire { [weak self] postDetailViewModel in
                guard let self = self else {
                    return
                }
                
                if postDetailViewModel.postModel.value.isFavorited {
                    self.viewModel.postDetail.value.isFavorited = true
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            viewModel.read.value = true
        }
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
        
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
        
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
                                                                    -Constants.titleRightMargin),
                                     ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: containerView,
                                                                 withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.pinBottomOfView(titleLabel, toBottomOfView: containerView, withMargin: -Constants.titleTopMargin),
                                     ConstraintUtil.pinLeftOfView(titleLabel, toLeftOfView: containerView, withMargin: Constants.titleLeftMargin)
                                    ])
        
        contentView.addSubview(readIConView)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(readIConView, inContainingView: containerView),
                                     ConstraintUtil.setHeight(Constants.readIconHeight, toView: readIConView),
                                     ConstraintUtil.pinLeftOfView(readIConView, toLeftOfView: containerView, withMargin: Constants.readIconLeftMargin),
                                     ConstraintUtil.setWidth(readIConView, constant: Constants.readIconHeight)
        ])
        
        contentView.addSubview(starImageBtn)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(starImageBtn, inContainingView: containerView),
                                     ConstraintUtil.setHeight(Constants.starIconSize, toView: starImageBtn),
                                     ConstraintUtil.setWidth(starImageBtn, constant: Constants.starIconSize),
                                     ConstraintUtil.pinLeftOfView(starImageBtn, toLeftOfView: containerView, withMargin: Constants.starIconLeftMargin)
        ])
    }

}
