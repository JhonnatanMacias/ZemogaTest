//
//  PostViewController.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 19/01/22.
//

import UIKit

protocol PostViewControllerDelegate: AnyObject {
    func detailViewDidUpdate(post: PostDetailViewModel)
}

class PostViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title: String = "Description"
        static let userTitle: String = "User"
        static let commentsTitle: String = "COMMENTS"
        static let pageTitle: String = "Post"
        
        static let titleLeftMargin: CGFloat = 10
        static let titleTopMargin: CGFloat = 12
        static let descriptionTopMargin: CGFloat = 4
        static let userInfoViewHeight: CGFloat = 130
        static let titleLabelHeight: CGFloat = 21
        static let headerHeight: CGFloat = 25
        
        static let postCellIdentifier: String = PostTableViewCell.reuseIdentifier
    }
    
    // MARK: - Properties
    
    private var titleLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
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
        userView.backgroundColor = .clear
        userView.translatesAutoresizingMaskIntoConstraints = false
        return userView
    }()
    
    private var commentLabel: UILabel = {
        let label = UILabel.newAutolayoutLabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .justified
        label.textColor = .black
        label.text = Constants.commentsTitle
        return label
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView.newAutolayoutTableView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let favoriteBtn: UIButton = {
        let iconBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        iconBtn.setImage(UIImage(systemName: "star")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        iconBtn.setImage(UIImage(systemName: "star.fill")?.withTintColor(UIColor.favoriteButtonColor(), renderingMode: .alwaysOriginal), for: .selected)
        return iconBtn
    }()
    
    weak var delegate: PostViewControllerDelegate?
    
    var viewModel: PostDetailViewModelProtocol! {
        didSet {
            
            viewModel.postModel.bindAndFire { [weak self] postDetail in
                guard let self = self else {
                    return
                }
                
                self.descriptionLabel.text = postDetail.description
                self.updateUserInfo(userInfo: postDetail.user)
                self.markLikeFavoriteIfIsNeeded(postDetail: postDetail)
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Initializer

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
        
        delegate?.detailViewDidUpdate(post: viewModel as! PostDetailViewModel)
    }
    
    private func setupPageStyle() {
        self.title = Constants.pageTitle
        view.backgroundColor = .systemGray6
        edgesForExtendedLayout = []
        addRightBarButtonITem()
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    private func addRightBarButtonITem() {
        let rightBarBtn = UIBarButtonItem()
        rightBarBtn.customView = favoriteBtn
        favoriteBtn.addTarget(self, action: #selector(didTapFavoriteBtn), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    private func markLikeFavoriteIfIsNeeded(postDetail: PostDetail) {
        favoriteBtn.isSelected = postDetail.isFavorited
    }
    
    // MARK: - Internal Functions
    
    func setupView() {
        setupPageStyle()
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(titleLabel,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(titleLabel,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(titleLabel, toTopOfView: view, withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.setHeight(Constants.titleLabelHeight, toView: titleLabel)
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
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: Constants.postCellIdentifier)
        NSLayoutConstraint.activate([ConstraintUtil.pinLeftOfView(tableView,
                                                                  toLeftOfView: view,
                                                                  withMargin: Constants.titleLeftMargin),
                                     ConstraintUtil.pinRightOfView(tableView,
                                                                   toRightOfView: view,
                                                                   withMargin: -Constants.titleLeftMargin),
                                     ConstraintUtil.pinTopOfView(tableView, toBottomOfView: userInfoView, withMargin: Constants.titleTopMargin),
                                     ConstraintUtil.pinBottomOfView(tableView, toBottomOfView: view)
        ])
    }
    
    func updateUserInfo(userInfo: User) {
        userInfoView.updateInfo(user: userInfo)
    }
    
    @objc func didTapFavoriteBtn() {
        favoriteBtn.isSelected = !favoriteBtn.isSelected
        let postDetail = viewModel.postModel.value
        postDetail.isFavorited = favoriteBtn.isSelected
        viewModel.postModel.value = postDetail
        viewModel.postModel = Bindable(postDetail)
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        
    }

}

extension PostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellsViewModel.value.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PostTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.cellsViewModel.value[indexPath.row]
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension PostViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0,
                                                y: 0,
                                                width: view.frame.size.width,
                                                height: Constants.headerHeight))
        returnedView.backgroundColor = .lightGray

        returnedView.addSubview(commentLabel)
        NSLayoutConstraint.activate([ConstraintUtil.centerViewVertically(commentLabel, inContainingView: returnedView),
                                     ConstraintUtil.setHeight(Constants.titleLabelHeight, toView: commentLabel),
                                     ConstraintUtil.pinLeftOfView(commentLabel, toLeftOfView: returnedView, withMargin: Constants.titleLeftMargin)
        ])

        return returnedView
    }
}
