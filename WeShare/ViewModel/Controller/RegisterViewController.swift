//
//  RegisterViewController.swift
//  WeShare
//
//  Created by Emmanuel George on 04/09/22.
//

import UIKit
class RegisterViewController: UIViewController {
    let registerAuthViewModel: AuthViewModel = AuthViewModel()
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let navBar = navigationController?.navigationBar else{print("no navigation bar found"); return}
        navBar.tintColor = .black
    }
    @IBAction func registerPressed(_ sender: UIButton) {
        registerAuthViewModel.email = emailTextfield.text
        registerAuthViewModel.password = passwordTextfield.text
        if  registerAuthViewModel.email != "" && registerAuthViewModel.password != ""  {
            registerAuthViewModel.registerUser()
            performSegue(withIdentifier: K.NavigationId.registerSegue, sender: self)
        } else {
            displayAlert(withTitle: "Error", message: "Please, enter your email and password")
        }
    }
    func displayAlert(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
