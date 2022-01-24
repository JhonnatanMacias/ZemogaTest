//
//  Post.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class Post: Codable  {
    
    var id: Int = 0
    var read: Bool = false
    var message: String = ""
    var postDetail: PostDetail = PostDetail()
    
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
    
    init() {}
    
    init(postReal: PostRealm) {
        id = postReal.id
        read = postReal.read
        message = postReal.message
        
        let postDetailObj = postReal.postDetail
        let user = postReal.postDetail.user
        postDetail = PostDetail(postDescription: postDetailObj?.postDescription ?? "",
                                user: User(name: user?.name ?? "",
                                           email: user?.email ?? "",
                                           phone: user?.phone ?? "",
                                           webSite: user?.webSite ?? ""),
                                isFavorite: postDetailObj?.isFavorited ?? false,
                                comments: postDetailObj?.comments.components(separatedBy: ",") ?? [""],
                                id: postReal.id)
    }
    
}
