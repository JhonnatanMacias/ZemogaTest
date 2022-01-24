//
//  PostsViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation
import RealmSwift

protocol PostsViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var postModel: Bindable<[Post]> { get }
    var postFavoritesModel: Bindable<[Post]> { get }
    var cellsViewModel: Bindable<[PostCellViewModel]> { get set }
    
    func postSelected(postViewModel: PostDetailViewModel, post: Post)
    func displayFavoritiesPost(onlyFavorites: Bool)
    
    func getPosts()
    func deleteAllPost()
    func removePost(index: Int, post: Post)
    func viewDidLoad()
    func markPostLikeFavorite(postDetail: PostDetail)
    
    // MARK: - Events

    var navigateToPostDetail: ((PostDetailViewModel) -> ())? { get set}
    
    var navigateToPostDetails: ((PostDetail) -> ())? { get set}
}

class PostsViewModel: PostsViewModelProtocol {
    
    var navigateToPostDetail: ((PostDetailViewModel) -> ())?
    var navigateToPostDetails: ((PostDetail) -> ())?
    var postModel: Bindable<[Post]> = Bindable([])
    var postAllModel: [Post] =  [Post]()
    var postFavoritesModel: Bindable<[Post]> = Bindable([])
    var cellsViewModel: Bindable<[PostCellViewModel]> = Bindable([])
    
    var postsRealm: [PostRealm]!
    
    func postSelected(postViewModel: PostDetailViewModel, post: Post) {
        markPostLikeRead(post: post)
        navigateToPostDetail?(postViewModel)
    }
    
    func postSelected(postDetail: PostDetail) {
        navigateToPostDetails?(postDetail)
    }
    
    let repository = PostsServices()
    
    init() { }
    
    func displayFavoritiesPost(onlyFavorites: Bool) {
        var postAux: [Post] = []
        
        if onlyFavorites {
            postAux = postModel.value.filter { post in
                post.postDetail.isFavorited
            }
        } else {
            postAux = postModel.value
        }
        
        cellsViewModel.value = postAux.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
    }
    
    func getPosts() {
        repository.getPostFromService { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let posts):
                self.setupModel(model: posts)
                self.castingToRealmObject(model: posts)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removePost(index: Int,  post: Post) {
        if let postToDelete = postsRealm.filter({ $0.id == post.id}).first {
            DatabaseManager.shared.deletePost(object: postToDelete)
            self.postModel.value.remove(at: index)
            self.cellsViewModel.value = postModel.value.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
        }
    }
    
    func deleteAllPost() {
        postModel.value.removeAll()
        cellsViewModel.value.removeAll()
    
        DatabaseManager.shared.deleteAll(objects: postsRealm)
    }
    
    func viewDidLoad() {
        let postAllModel = DatabaseManager.shared.fetchPosts()
        
        if postAllModel.isEmpty || postAllModel.count < 1 {
            getPosts()
        } else {
            postsRealm = DatabaseManager.shared.fetchPosts()
            populateViewModelFromDB()
        }
    }
    
    func populateViewModelFromDB() {
        let posts = postsRealm.map { Post(postReal: $0) }
        setupModel(model: posts)
    }
    
    func storagePosts(model: [PostRealm]) {
        DispatchQueue.main.async { [weak self] in
            DatabaseManager.shared.add(posts: model)
            self?.postsRealm = model
        }
    }
    
    func castingToRealmObject(model: [Post])  {
        let postsObj: [PostRealm] = model.map { PostRealm(post: $0) }
        storagePosts(model: postsObj)
    }
    
    func markPostLikeRead(post: Post) {
        if let postToUpdate = postsRealm.filter({ $0.id == post.id}).first {
            DatabaseManager.shared.markPostRead(post: postToUpdate)
        }
    }
    
    func markPostLikeFavorite(postDetail: PostDetail) {
        if let postToUpdate = postsRealm.filter({ $0.id == postDetail.id }).first {
            DatabaseManager.shared.markPostFavorited(post: postToUpdate,
                                                     isFavorited: postDetail.isFavorited)
        }
    }
    
    private func setupModel(model: [Post]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.postModel.value = model
            self.cellsViewModel.value = model.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
        }
    }
}
