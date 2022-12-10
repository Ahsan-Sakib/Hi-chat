//
//  LoginViewController.swift
//  Hi-Chat
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "AppIcon")
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        let uiView = CGRect(x: 0,
                            y: 0,
                            width: 5,
                            height: 0)
        field.leftView = UIView(frame: uiView)
        field.leftViewMode = .always
        field.returnKeyType = .continue
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password...."
        let uiView = CGRect(x: 0,
                            y: 0,
                            width: 5,
                            height: 0)
        field.leftView = UIView(frame: uiView)
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        return field
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login page"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(tapOnRegistration))

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)

        emailField.delegate = self
        passwordField.delegate = self

        //logo image
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
    }

    @objc private func loginButtonTapped(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()

        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty && !password.isEmpty && password.count >= 6 else{
              alertLoginError()
            return
        }
    }

    private func alertLoginError(){
        let alert = UIAlertController(title: "Woops", message: "Please enter all information", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: CGFloat((scrollView.width - size)/2),
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.frame.width/2

        emailField.frame = CGRect(x:  30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x:  30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)

        loginButton.frame = CGRect(x:  30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
    }

    @objc private func tapOnRegistration(){
        print("tap on registration")
        let registrationVC = RegistrationViewController()
        registrationVC.title = "Create Account"
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }

    private func tapOnLoginButton(){
        print("tap on registration")
        let registrationVC = RegistrationViewController()
        registrationVC.title = "Create Account"
        self.navigationController?.pushViewController(registrationVC, animated: true)
    }
}


extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            loginButtonTapped()
        }
        return true
    }
}
