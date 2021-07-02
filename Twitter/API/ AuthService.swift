//
//  Firebase.swift
//  Twitter
//
//  Created by Ivan Kopiev on 02.07.2021.
//

import Firebase
import UIKit

class AuthService {
    
    static let shared = AuthService()
    private init() {}
        
    func registrer(user: User, comletion: @escaping (Error?) -> Void) {
        
        let fileName = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGE.child(fileName)
        storageRef.putData(user.image, metadata: nil) { (_,_) in
            print("DEBUG: - Image is uploaded")
            storageRef.downloadURL { (url, errorUrl) in
                guard let profileImageUrl = url?.absoluteString else {return}

                Auth.auth().createUser(withEmail: user.mail, password: user.password) { authDataResult, error in
                    if let error = error {
                        comletion(error)
                        return
                    } else {
                        comletion(nil)
                    }
                    guard let uid = authDataResult?.user.uid else {return}
                    let value = ["email": user.mail,
                                 "username": user.username,
                                 "fullname":user.fullname,
                                 "profileImageUrl": profileImageUrl]
                    
                    REF_USERS.child(uid).updateChildValues(value) { (_,_) in
                        print("DEBUG: - Successfully updates user informations")
                    }
                }
            }
        }
    }

}
