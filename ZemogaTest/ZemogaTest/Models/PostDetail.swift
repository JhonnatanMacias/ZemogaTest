//
//  PostDetail.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class PostDetail: Codable {
    
    var description: String = ""
    var user: User!
    var comments: [String] = []
    var isFavorited: Bool = false
    
    // MARK: - Initializers

    init(description: String, user: User, isFavorite: Bool, comments: [String]) {
        self.description = description
        self.user = user
        self.comments = comments
        self.isFavorited = isFavorite
    }
    
    init() {}
}

//class PostDetail: Codable {
//    var title: String = ""
//    var isFavorited: Bool = false
//    var comments: [String] = []
//    var user: Users
//}
