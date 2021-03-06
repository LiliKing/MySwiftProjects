//
//  User.swift
//  AutoLayout
//
//  Created by Xiangli Jin on 16/2/16.
//  Copyright © 2016年 Xiangli Jin. All rights reserved.
//

import Foundation

struct User
{
    let name: String
    let company: String
    let login: String
    let password: String
    
    static func login(login: String ,password: String ) -> User?{
        if let user = database[login] {
            if user.password == password{
                return user
            }
        }
        return nil
    }
    
    
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>()
        for user in [
            User(name: "John Appleseed", company: "Apple", login: "japple", password: "foo"),
            User(name: "Madison Bumgarner", company: "World Champion", login: "San Francisco Giants", password: "foo"),
            User(name: "jxl", company: "Hengtian", login: "jxl", password: "jxl")
        
        ]
        {
            theDatabase[user.login] = user
        }
        return theDatabase
    }()
    
}
