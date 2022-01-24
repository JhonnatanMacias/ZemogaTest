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
    
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Work With Objects
    
    
    func add(posts: [PostRealm]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(posts)
            }
        } catch let error as NSError {
            print("An error ocurred while saving: \(error)")
        }
    }
    
    
    func deleteAll(objects: [PostRealm]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(objects)
            }
        } catch let error as NSError {
            print("An error ocurred while delete: \(error)")
        }
    }
    
    func deletePost(object: PostRealm) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(object)
            }
        } catch let error as NSError {
            print("An error ocurred while delete an post: \(error)")
        }
    }
    
    func fetchPosts() -> [PostRealm] {
        do {
            let realm = try Realm()
            return Array(realm.objects(PostRealm.self))
        } catch let error as NSError {
            print("An error ocurred while update an post: \(error)")
        }
     
        return [PostRealm]()
    }
    
    func markPostRead(post: PostRealm) {
        do {
            let realm = try Realm()
            try realm.write {
                post.read = true
            }
        } catch let error as NSError {
            print("An error ocurred while update an post: \(error)")
        }
    }
    
    func markPostFavorited(post: PostRealm, isFavorited: Bool) {
        do {
            let realm = try Realm()
            try realm.write {
               post.postDetail.isFavorited  = isFavorited
            }
        } catch let error as NSError {
            print("An error ocurred while update an post: \(error)")
        }
    }
    
}
