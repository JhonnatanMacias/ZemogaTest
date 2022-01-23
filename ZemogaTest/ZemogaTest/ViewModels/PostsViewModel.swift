//
//  PostsViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

protocol PostsViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var postAllModel: Bindable<[Post]> { get }
    var postModel: Bindable<[Post]> { get }
    var postFavoritesModel: Bindable<[Post]> { get }
    var cellsViewModel: Bindable<[PostCellViewModel]> { get set }
    
    func postSelected(postViewModel: PostDetailViewModel)
    func displayFavoritiesPost(onlyFavorites: Bool)
    
    func getPosts()
    func removePost(index: Int)
    
    // MARK: - Events

    var navigateToPostDetail: ((PostDetailViewModel) -> ())? { get set}
    
    var navigateToPostDetails: ((PostDetail) -> ())? { get set}
}

class PostsViewModel: PostsViewModelProtocol {
    
    var navigateToPostDetail: ((PostDetailViewModel) -> ())?
    var navigateToPostDetails: ((PostDetail) -> ())?
    var postModel: Bindable<[Post]> = Bindable([])
    var postAllModel: Bindable<[Post]> = Bindable([])
    var postFavoritesModel: Bindable<[Post]> = Bindable([])
    var cellsViewModel: Bindable<[PostCellViewModel]> = Bindable([])
    
    func postSelected(postViewModel: PostDetailViewModel) {
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func removePost(index: Int) {
        self.postModel.value.remove(at: index)
        self.cellsViewModel.value = postModel.value.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
    }
    
    private func setupModel(model: [Post]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            
            self.postModel.value = model
            self.postAllModel.value = model
            self.cellsViewModel.value = model.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
        }
    }
}
