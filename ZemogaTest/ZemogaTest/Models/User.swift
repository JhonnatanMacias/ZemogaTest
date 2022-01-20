//
//  User.swift
//  ZemogaTest
//
//  Created by Jhonnatan Macias on 20/01/22.
//

import Foundation

class User {
    
    var name: String = ""
    var phone: String = ""
    var email: String = ""
    var webSite: String = ""
    
    // MARK: - Initializers

    init(name: String, email: String, phone: String, webSite: String) {
        self.name = name
        self.email = email
        self.phone = phone
        self.webSite = webSite
    }
}
