//
//  PostsCellViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

protocol PostCellViewModelProtocol: AnyObject {
    
    var cellModel: Bindable<Post> { get }
    var message: Bindable<String> { get }
    var postDetail: Bindable<PostDetail> { get }
}

class PostCellViewModel: PostCellViewModelProtocol {
    
    var cellModel: Bindable<Post> = Bindable(Post())
    var message: Bindable<String> = Bindable("")
    var postDetail: Bindable<PostDetail> = Bindable(PostDetail())
   
    init(model: Post) {
        cellModel.value = model
        message.value = model.message
        postDetail.value = model.postDetail
    }
    
}
