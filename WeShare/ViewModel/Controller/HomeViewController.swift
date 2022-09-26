//
//  HomeViewController.swift
//  WeShare
//
//  Created by Emmanuel George on 04/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var appVersion: UILabel!
    @IBOutlet weak var appTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isUserLoggedIn")==true{
            let homeVc = storyboard?.instantiateViewController(withIdentifier: "dashboardVc") as! DashboardTableViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        appTitle.text=""
        var charIndex = 0.0
        let titleText = "WeShare"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.appTitle.text?.append(letter)
            }
            charIndex+=1
            
        }
        appVersion.text = "version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "null").0 "
    }
    
}


