//
//  PostDetail.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class PostDetail {
    
    var description: String = ""
    var user: User!
    var comments: [String] = []
    
    // MARK: - Initializers

    init(description: String, user: User, comments: [String]) {
        self.description = description
        self.user = user
        self.comments = comments
    }
    
    init() {
        
    }
}
