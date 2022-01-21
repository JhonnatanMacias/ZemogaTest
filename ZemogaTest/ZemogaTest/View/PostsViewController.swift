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
    
    var viewModel: PostsViewModelProtocol! {
        didSet {
            loadViewIfNeeded()
            
            viewModel.postModel.bindAndFire { [weak self] _ in
                guard let self = self else {
                      return
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.pageTitle
        
        setNeedsStatusBarAppearanceUpdate()
        setupSegmentedControlStyle()
        setupTableView()
        
        viewModel = PostsViewModel(model: FakePostModel().model)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    // MARK: - Private Functions
    
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
        return viewModel.cellsViewModel.value.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostsTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.viewModel = viewModel.cellsViewModel.value[indexPath.row]
        return cell
        }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
