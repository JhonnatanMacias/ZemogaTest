//
//  FakePostModel.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class FakePostModel {
    
    var model: [Post] = []
    let detail: String = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters"
    let message: String = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s"
    
    
    init() {
        for index in 1...5 {
            model.append(Post(read: false,
                              message: "\(index) \(message)",
                              postDetail: PostDetail(description: detail,
                                                     user: User(name: "Jhonnatan",
                                                                email: "Jhonnatan@mail.com",
                                                                phone: "321456786",
                                                                webSite: "jhonnatan.com"),
                                                     isFavorite: false,
                                                     comments: ["What is Lorem Ipsum?",
                                                                "Where does it come from?",
                                                                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour"])))
        }
        
        let message2 = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, here are many variations of passages of Lorem Ipsum available,"
        
        model.append(Post(read: true,
                          message: "6 \(message2)",
                          postDetail: PostDetail(description: detail,
                                                 user: User(name: "Jhonnatan",
                                                            email: "Jhonnatan@mail.com",
                                                            phone: "321456786",
                                                            webSite: "jhonnatan.com"), isFavorite: true,
                                                 comments: ["What is Lorem Ipsum?",
                                                            "Where does it come from?",
                                                            "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour"])))
       
    }
    
}
