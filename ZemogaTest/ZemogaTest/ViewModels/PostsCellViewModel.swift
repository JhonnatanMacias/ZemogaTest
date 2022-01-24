//
//  PostsCellViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

protocol PostCellViewModelProtocol: AnyObject {
    
    var cellModel: Bindable<Post> { get }
    var read: Bindable<Bool> { get }
    var isFavorited: Bindable<Bool> { get }
    var message: Bindable<String> { get }
    var postDetail: Bindable<PostDetail> { get }
    
    var postDetailViewModel: Bindable<PostDetailViewModel> { get set}
}

class PostCellViewModel: PostCellViewModelProtocol {
    
    var cellModel: Bindable<Post> = Bindable(Post())
    var read: Bindable<Bool> = Bindable(false)
    var isFavorited: Bindable<Bool> = Bindable(false)
    var message: Bindable<String> = Bindable("")
    var postDetail: Bindable<PostDetail> = Bindable(PostDetail())
    var postDetailViewModel: Bindable<PostDetailViewModel> = Bindable(PostDetailViewModel(model: PostDetail()))
   
    init(model: Post, postDetailViewModel: PostDetailViewModel) {
        cellModel.value = model
        read.value = model.read
        message.value = model.message
        postDetail.value = model.postDetail
        self.postDetailViewModel.value = postDetailViewModel
        isFavorited.value = self.postDetailViewModel.value.postModel.value.isFavorited
    }
    
}
