//
//  AuthViewModel.swift
//  WeShare
//
//  Created by Emmanuel George on 15/09/22.
//

import Foundation
import Firebase


class AuthViewModel: NSObject {
    static let shared = AuthViewModel()
    var email : String?
    var password : String?
    var completionHandler: ((AuthDataResult?, NSError?) -> Void)?
    //MARK: Methods
    func loginUser(email: String, password: String,completion: @escaping(Bool)->()) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { (authResult, error) in
            
            if let _error = error {
                     print(_error.localizedDescription)
                completion(false)
                 } else {
                     UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                     UserDefaults.standard.synchronize()
                     completion(true)
                 }
            })
    }
    func registerUser() {
        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (authResult, error) in
                if let handler = self.completionHandler {
                    handler(authResult, error as NSError?)
                }
            })
    }
    func logOut(){
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }

    }
}
