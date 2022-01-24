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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
            }
            
            viewModel?.cellsViewModel.bindAndFire(listener: { [weak self] _ in
                guard let self = self else {
                      return
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            
            viewModel?.navigateToPostDetail = {  [weak self] viewModel in
                guard let self = self else {
                      return
                }
                
                let postDetailVC = PostViewController()
                postDetailVC.viewModel = viewModel
                self.navigationController?.pushViewController(postDetailVC, animated: true)
            }
        }
    }
    
    // MARK: - Initializer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.pageTitle
        setupViews()
        viewModel = PostsViewModel()
        viewModel?.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(favoritePost(aNotification:)), name: NSNotification.Name.init("NotificationIdentifier"), object: nil)
        
    }
    
    @objc func favoritePost(aNotification: NSNotification) {
        if let userInfo = aNotification.userInfo,
           let postDetail = userInfo["Detail"] as? PostDetail {
            viewModel?.markPostLikeFavorite(postDetail: postDetail)
            tableView.reloadData()
        }
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
        viewModel?.getPosts()
    }
    
    @IBAction func didTapDeleteAllButton(_ sender: Any) {
        viewModel?.deleteAllPost()
    }
    
    @IBAction func handleSegmentAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            viewModel?.displayFavoritiesPost(onlyFavorites: false)
        } else {
            viewModel?.displayFavoritiesPost(onlyFavorites: true)
        }
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
            viewModel.postModel.value[indexPath.row].read = true
            viewModel.postSelected(postViewModel: viewModel.cellsViewModel.value[indexPath.row].postDetailViewModel.value,
                                   post: viewModel.postModel.value[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
          return true
      }
      
      func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
          return UITableViewCell.EditingStyle.delete
      }
      
      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
          if editingStyle == .delete {
              guard let viewModel = viewModel else { return }
              // Delete the row from the data source
              tableView.beginUpdates()
              viewModel.removePost(index: indexPath.row,
                                   post: viewModel.postModel.value[indexPath.row])
              tableView.deleteRows(at: [indexPath], with: .fade)
              tableView.endUpdates()
          }
      }
    
}

