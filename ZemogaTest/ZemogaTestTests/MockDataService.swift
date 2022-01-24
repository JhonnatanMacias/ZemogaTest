//
//  MockDataService.swift
//  ZemogaTestTests
//
//  Created by Jhonnatan Macias on 23/01/22.
//

import Foundation
import UIKit
@testable import ZemogaTest

protocol DataService {
    func getPosts(_ completion: @escaping ([Post]?, Error?) -> Void)
}

class MockPostsServices: PostsServices {
   
    var model: [Post]? = [Post()]
    var error: Error? = NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey : "Object does not exist"])

   
    override func getPostFromService(completionHandler: @escaping(Result<[Post], Error>) -> Void) {
        
        guard let posts = self.model else {
            completionHandler(.failure(error!))
            return
        }
        
        completionHandler(.success(posts))
        
    }
}
