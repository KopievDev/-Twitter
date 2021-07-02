//
//  Constant.swift
//  Twitter
//
//  Created by Ivan Kopiev on 02.07.2021.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_images")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")

