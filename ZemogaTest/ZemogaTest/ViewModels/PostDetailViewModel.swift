//
//  PostDetailViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 21/01/22.
//

import Foundation

protocol PostDetailViewModelProtocol: AnyObject {
    
    // MARK: - Properties

    var postModel: Bindable<PostDetail> { get }
    var cellsViewModel: Bindable<[CommentCellViewModel]> { get }
    
    // MARK: - Events

    var startedPostDetail: ((PostDetail) -> ())? { get set}
}

class PostDetailViewModel: PostDetailViewModelProtocol {
    
    var startedPostDetail: ((PostDetail) -> ())?
    
    var navigateToPostDetail: ((PostDetail) -> ())?
    var postModel: Bindable<PostDetail> = Bindable(PostDetail())
    var cellsViewModel: Bindable<[CommentCellViewModel]> = Bindable([])
    
    init(model: PostDetail) {
        postModel.value = model
        cellsViewModel.value = model.comments.compactMap {
            CommentCellViewModel(comment: $0) }
    }
}
