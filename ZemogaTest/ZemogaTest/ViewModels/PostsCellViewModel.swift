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
    var star: Bindable<Bool> { get }
    var message: Bindable<String> { get }
    var postDetail: Bindable<PostDetail> { get }
}

class PostCellViewModel: PostCellViewModelProtocol {
    
    var cellModel: Bindable<Post> = Bindable(Post())
    var read: Bindable<Bool> = Bindable(false)
    var star: Bindable<Bool> = Bindable(false)
    var message: Bindable<String> = Bindable("")
    var postDetail: Bindable<PostDetail> = Bindable(PostDetail())
   
    init(model: Post) {
        cellModel.value = model
        read.value = model.read
        star.value = model.star
        message.value = model.message
        postDetail.value = model.postDetail
    }
    
}
