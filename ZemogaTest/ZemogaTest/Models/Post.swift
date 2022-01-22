//
//  Post.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class Post {
    
    var message: String = ""
    var postDetail: PostDetail = PostDetail()
    
    // MARK: - Initializers

    init(message: String, postDetail: PostDetail) {
        self.message = message
        self.postDetail = postDetail
    }
    
    init() {}
    
}
