//
//  LoginViewController.swift
//  WeShare
//
//  Created by Emmanuel George on 04/09/22.
//

import UIKit

class LoginViewController: UIViewController {
    var iconClick = true
    var buttonActive = false
    let loginAuthViewModel: AuthViewModel = AuthViewModel()
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(systemName: K.ImageName.closedEyeIcon,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium ))
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        guard let navBar = navigationController?.navigationBar else{print("no navigation bar found"); return}
        navBar.tintColor = .black
    }
    @IBAction func loginPressed(_ sender: UIButton) {
     loginAuthViewModel.email = emailTextfield.text
        loginAuthViewModel.password = passwordTextfield.text
        if loginAuthViewModel.email != "" && loginAuthViewModel.password != ""  {
            loginAuthViewModel.loginUser(email: emailTextfield.text!, password:  passwordTextfield.text!) { res in
                self.performSegue(withIdentifier: K.NavigationId.loginSegue, sender: self)
            }
           
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
    @IBAction func iconPressed(_ sender: UIButton) {
        if(iconClick == true) {
            passwordTextfield.isSecureTextEntry = false
            let image = UIImage(systemName: K.ImageName.openedEyeIcon,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium ))
            button.setImage(image, for: .normal)
            button.tintColor = .systemBlue
        } else {
            passwordTextfield.isSecureTextEntry = true
            let image = UIImage(systemName: K.ImageName.closedEyeIcon,withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium ))
            button.setImage(image, for: .normal)
            button.tintColor = .systemBlue
        }
        iconClick = !iconClick
    }
}
