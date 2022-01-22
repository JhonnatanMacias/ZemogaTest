//
//  PostsViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

protocol PostsViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var postModel: Bindable<[Post]> { get }
    var cellsViewModel: Bindable<[PostCellViewModel]> { get set }
    
    func postSelected(postViewModel: PostDetailViewModel)
    
    // MARK: - Events

    var navigateToPostDetail: ((PostDetailViewModel) -> ())? { get set}
    
    var navigateToPostDetails: ((PostDetail) -> ())? { get set}
}

class PostsViewModel: PostsViewModelProtocol {
    
    // actualizar Modelo
    
    var navigateToPostDetail: ((PostDetailViewModel) -> ())?
    var navigateToPostDetails: ((PostDetail) -> ())?
    var postModel: Bindable<[Post]> = Bindable([])
    var cellsViewModel: Bindable<[PostCellViewModel]> = Bindable([])
    
    func postSelected(postViewModel: PostDetailViewModel) {
        navigateToPostDetail?(postViewModel)
    }
    
    func postSelected(postDetail: PostDetail) {
        navigateToPostDetails?(postDetail)
    }
    
    init(model: [Post]) {
        postModel.value = model
        cellsViewModel.value = model.compactMap { PostCellViewModel(model: $0, postDetailViewModel: PostDetailViewModel(model: $0.postDetail)) }
    }
}
