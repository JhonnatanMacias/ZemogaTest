//
//  PostViewController.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 18/01/22.
//

import UIKit

class PostsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let pageTitle: String = "Post"
        static let postCellIdentifier: String = PostsTableViewCell.reuseIdentifier
        
    }
    
    // MARK: - Properties
    
    @IBOutlet private var postSegmentedControl: UISegmentedControl!
    @IBOutlet private var tableView: UITableView!
    
    var viewModel: PostsViewModelProtocol? {
        didSet {
            loadViewIfNeeded()
            
            viewModel?.postModel.bindAndFire { [weak self] _ in
                guard let self = self else {
                      return
                }
                
                self.tableView.reloadData()
            }
            
            viewModel?.navigateToPostDetail = {  [weak self] viewModel in
                let postDetailVC = PostViewController()
                postDetailVC.viewModel = viewModel
                self?.navigationController?.pushViewController(postDetailVC, animated: true)
            }
        }
    }
    
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.pageTitle
        setupViews()
        viewModel = PostsViewModel(model: FakePostModel().model)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        hideNavigationBarBackBtnTitle()
    }
    
    // MARK: - Private Functions
    
    private func setupViews() {
        setNeedsStatusBarAppearanceUpdate()
        setupSegmentedControlStyle()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: Constants.postCellIdentifier)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
    }
    
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

    private func hideNavigationBarBackBtnTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    
    // MARK: - Internal Functions
    
    @IBAction func didTapRefreshButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
    }
    
    @IBAction func handleSegmentChange(_ sender: Any) {
   
    }
}

extension PostsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        
        return viewModel.cellsViewModel.value.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.cellsViewModel.value[indexPath.row]
        return cell
        }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            
            viewModel.postSelected(postViewModel: viewModel.cellsViewModel.value[indexPath.row].postDetailViewModel.value)
        }
    }
    
}

