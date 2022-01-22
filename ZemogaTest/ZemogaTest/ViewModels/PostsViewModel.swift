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
    var cellsViewModel: Bindable<[PostCellViewModel]> { get }
    
    func postSelected(postDetail: PostDetail)
    
    // MARK: - Events

    var navigateToPostDetail: ((PostDetail) -> ())? { get set}
}

class PostsViewModel: PostsViewModelProtocol {
    
    var navigateToPostDetail: ((PostDetail) -> ())?
    var postModel: Bindable<[Post]> = Bindable([])
    var cellsViewModel: Bindable<[PostCellViewModel]> = Bindable([])
   
    func postSelected(postDetail: PostDetail) {
        navigateToPostDetail?(postDetail)
    }
    
    init(model: [Post]) {
        postModel.value = model
        cellsViewModel.value = model.compactMap { PostCellViewModel(model: $0) }
    }
}
