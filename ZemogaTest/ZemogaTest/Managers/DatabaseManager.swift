//
//  DatabaseManager.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 23/01/22.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    // MARK: - Properties
    
    static let shared = DatabaseManager()
    
    private let realm = try! Realm()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Work With Objects
    
    func add(posts: [PostRealm]) {
        try! realm.write {
            realm.add(posts)
        }
    }
    
    func deleteAll(objects: [PostRealm]) {
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func deletePost(object: PostRealm) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func fetchPosts() -> [PostRealm] {
        return Array(realm.objects(PostRealm.self))
    }
    
    func markPostRead(post: PostRealm) {
        try! realm.write {
            post.read = true
        }
    }
    
    func markPostFavorited(post: PostRealm, isFavorited: Bool) {
        try! realm.write {
            post.postDetail.isFavorited  = isFavorited
        }
    }
    
}
