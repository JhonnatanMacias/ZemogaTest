//
//  User.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation
import RealmSwift

class User: Object, Codable {
    
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
