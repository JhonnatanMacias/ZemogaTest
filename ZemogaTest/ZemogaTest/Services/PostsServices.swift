//
//  PostsServices.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 22/01/22.
//

import Alamofire
import Foundation

class PostsServices: BaseService {
   
    struct Constants {
        static let endPoint = "JhonnatanMacias/MyJSonPostServer/posts"
        static let baseURL = "https://my-json-server.typicode.com/"
    }
    
    static let shared: PostsServices = PostsServices()
    
    init() {
        super.init(baseURL: Constants.baseURL)
    }
    
    func getPostFromService(completionHandler: @escaping(Result<[Post], Error>) -> Void) {

        getCodable(URL: baseURL + Constants.endPoint,
                   parameters: nil, responseType: [Post].self) { (response: [Post]?, error: NSError?) in
            if let error = error {
                completionHandler(.failure(error as Error))
            } else if let response = response {
                completionHandler(.success(response))
            } else {
                let erro: Error =  NSError(domain: "", code: 404, userInfo: nil) as Error
                completionHandler(.failure(erro))
            }
        }
        
    }
}
