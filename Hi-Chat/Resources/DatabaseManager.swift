//
//  DatabaseManager.swift
//  Hi-Chat
//
//  Created by Ahsan Sakib on 17/12/22.
//

import Foundation

import FirebaseDatabase

final class DatabaseManager{
    static let shared = DatabaseManager()

    private let database = Database.database().reference()
}

 // MARK:-  Account Management

extension DatabaseManager {
    public func userExist(with email: String, completion: @escaping((Bool)->Void)){
        database.child(email).observeSingleEvent(of: .value) { snapShort in
            guard snapShort.value as? String  != nil else{
                completion(false)
                return
            }

            completion(true)
        }
    }

    ///inserts new user
    public func insertUser(with user: ChatAppUser){
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]
        )
    }
}

struct ChatAppUser{
    let firstName: String
    let lastName: String
    let emailAddress: String
    var safeEmail: String{
        return emailAddress.flatEmail()
    }
}
