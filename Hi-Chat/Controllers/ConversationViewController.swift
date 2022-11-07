//
//  ViewController.swift
//  Hi-Chat
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        if (!isLoggedIn){
            let loginVC = LoginViewController()
            let navController = UINavigationController(rootViewController: loginVC) // a new view controller with navigation bar
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: false)
        }
    }
}

