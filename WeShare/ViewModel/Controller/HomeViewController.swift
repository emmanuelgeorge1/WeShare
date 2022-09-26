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
        if UserDefaults.standard.bool(forKey: K.userDefaultKey)==true{
            let homeVc = storyboard?.instantiateViewController(withIdentifier: K.NavigationId.dashboardStoryboardId) as! DashboardTableViewController
            self.navigationController?.pushViewController(homeVc, animated: false)
        }
        animateText()
    }
   private func animateText(){
        appTitle.text=""
        var charIndex = 0.0
       let titleText = K.appName
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1*charIndex, repeats: false) { (timer) in
                self.appTitle.text?.append(letter)
            }
            charIndex+=1
        }
       appVersion.text = "version \(Bundle.main.object(forInfoDictionaryKey: K.cfBundleKey) ?? "Nil").0 "
    }
}


