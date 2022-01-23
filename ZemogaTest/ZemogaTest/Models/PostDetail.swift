//
//  PostDetail.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation
import RealmSwift

class PostDetail: Object, Codable {
    
    @objc dynamic var postDescription: String = ""
    @objc dynamic  var user: User!
    var comments: [String] = []
    @objc dynamic  var isFavorited: Bool = false
    
    var commentsObj: List<String>? = List<String>()
    
    // MARK: - Initializers

    init(postDescription: String, user: User, isFavorite: Bool, comments: [String]) {
        self.postDescription = postDescription
        self.user = user
        self.comments = comments
        self.isFavorited = isFavorite
    }
    
    override init() {}
}
