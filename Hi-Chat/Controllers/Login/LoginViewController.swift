//
//  LoginViewController.swift
//  Hi-Chat
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login page"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(tapOnRegistration))
        //logo image
        view.addSubview(imageView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = view.frame.size.width / 3
        imageView.frame = CGRect(x: CGFloat((view.frame.size.width - size)/2),
                                 y: 150,
                                 width: size,
                                 height: size)
    }

    @objc private func tapOnRegistration(){
        print("tap on registration")
        let registrationVC = RegistrationViewController()
        registrationVC.title = "Create Account"
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
}
