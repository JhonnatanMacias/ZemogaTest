//
//  PostsViewModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

protocol PostsViewModelProtocol: AnyObject {

    var postModel: Bindable<[Post]> { get }
    var cellsViewModel: Bindable<[PostCellViewModel]> { get }
}

class PostsViewModel: PostsViewModelProtocol {
    
    var postModel: Bindable<[Post]> = Bindable([])
    var cellsViewModel: Bindable<[PostCellViewModel]> = Bindable([])
    
    
    init(model: [Post]) {
        postModel.value = model
        cellsViewModel.value = model.compactMap { PostCellViewModel(model: $0) }
    }
}
