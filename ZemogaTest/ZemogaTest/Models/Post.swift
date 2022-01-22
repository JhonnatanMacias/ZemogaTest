//
//  Post.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class Post {
    
    var read: Bool = false
    var star: Bool = false
    var message: String = ""
    var postDetail: PostDetail = PostDetail()
    
    // MARK: - Initializers

    init(read: Bool, star: Bool, message: String, postDetail: PostDetail) {
        self.read = read
        self.star = star
        self.message = message
        self.postDetail = postDetail
    }
    
    init() {}
    
}
