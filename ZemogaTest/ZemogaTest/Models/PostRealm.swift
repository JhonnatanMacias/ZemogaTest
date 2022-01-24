//
//  PostRealm.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 23/01/22.
//

import Foundation

import RealmSwift

class PostRealm: Object  {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var read: Bool = false
    @objc dynamic var message: String = ""
    @objc dynamic var postDetail: PostDetailRealm! = PostDetailRealm()
    
    // MARK: - Initializers

    init(read: Bool, message: String, postDetail: PostDetailRealm) {
        self.read = read
        self.message = message
        self.postDetail = postDetail
    }
    
    override init() {}
    
    init(post: Post) {
        let postComments: String = post.postDetail.comments.joined(separator: ",")
        let user = post.postDetail.user
        
        id = post.id
        read = post.read
        message = post.message
        postDetail =  PostDetailRealm(postDescription: post.postDetail.postDescription,
                                      user: UserRealm(name: user?.name ?? "",
                                                      email: user?.email ?? "",
                                                      phone: user?.phone ?? "",
                                                      webSite: user?.webSite ?? ""),
                                      isFavorite: post.postDetail.isFavorited,
                                      comments: postComments)
        
    }
    
}

class PostDetailRealm: Object {
    
    @objc dynamic var postDescription: String = ""
    @objc dynamic var user: UserRealm!
    @objc dynamic var isFavorited: Bool = false
    @objc dynamic var comments: String = ""
    
    // MARK: - Initializers

    init(postDescription: String, user: UserRealm, isFavorite: Bool, comments: String) {
        self.postDescription = postDescription
        self.user = user
        self.comments = comments
        self.isFavorited = isFavorite
    }
    
    override init() {}
}

class UserRealm: Object, Codable {
    
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var webSite: String = ""
    
    // MARK: - Initializers

    init(name: String, email: String, phone: String, webSite: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.webSite = webSite
    }
    
    override init() {}
}
