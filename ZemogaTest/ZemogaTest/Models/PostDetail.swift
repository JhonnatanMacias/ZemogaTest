//
//  PostDetail.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class PostDetail: Codable {
    
    var id: Int = 0
    var postDescription: String = ""
    var user: User!
    var comments: [String] = []
    var isFavorited: Bool = false
    
    // MARK: - Initializers

    init(postDescription: String, user: User, isFavorite: Bool, comments: [String], id: Int) {
        self.postDescription = postDescription
        self.user = user
        self.comments = comments
        self.isFavorited = isFavorite
        self.id = id
    }
    
    init() {}
}
