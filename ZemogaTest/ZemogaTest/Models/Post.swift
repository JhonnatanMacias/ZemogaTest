//
//  Post.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation
import RealmSwift

class Post: Object, Codable  {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var read: Bool = false
    @objc dynamic var message: String = ""
    @objc dynamic var postDetail: PostDetail! = PostDetail()
    
    enum CodingKeys: String, CodingKey {
        case id, read, message
        case postDetail = "PostDetail"
    }
    
    // MARK: - Initializers

    init(read: Bool, message: String, postDetail: PostDetail) {
        self.read = read
        self.message = message
        self.postDetail = postDetail
    }
    
    override init() {}
    
}

// MARK: - PostElement
//class PostElement: Codable {
//    let id: Int
//    var read: Bool = false
//    var message: String = ""
//    let postDetail: PostDetail
//
//    enum CodingKeys: String, CodingKey {
//        case id, read, message
//        case postDetail = "PostDetail"
//    }
//}

// MARK: - PostDetail
//class PostDetail: Codable {
//    var title: String = ""
//    var isFavorited: Bool = false
//    var comments: [String] = []
//    var user: Users
//}

// MARK: - User
//class Users: Codable {
//    var name: String
//    var email: String
//    var phone: String
//    var webSite: String
//}

//typealias Post = [PostElement]

