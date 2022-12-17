//
//  RegistrationViewController.swift
//  Hi-Chat
//
//  Created by BJIT-SAKIB on 7/11/22.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let firstNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "First Name"
        let uiView = CGRect(x: 0,
                            y: 0,
                            width: 5,
                            height: 0)
        field.leftView = UIView(frame: uiView)
        field.leftViewMode = .always
        field.returnKeyType = .continue
        return field
    }()

    private let lastNameField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Last Name"
        let uiView = CGRect(x: 0,
                            y: 0,
                            width: 5,
                            height: 0)
        field.leftView = UIView(frame: uiView)
        field.leftViewMode = .always
        field.returnKeyType = .continue
        return field
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

    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register page"
        view.backgroundColor = .white
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector())

        registerButton.addTarget(self, action: #selector(validateField), for: .touchUpInside)

        emailField.delegate = self
        passwordField.delegate = self

        //scrollView.isUserInteractionEnabled = true
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeImage))
        imageView.addGestureRecognizer(gesture)
        //logo image
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
    }

    @objc private func validateField(){
        guard let email = emailField.text, let password = passwordField.text,
              let firstName = firstNameField.text, let lastName = lastNameField.text,
              !email.isEmpty && !password.isEmpty && !firstName.isEmpty && !lastName.isEmpty && password.count >= 6 else{
            alertRegistrationError()
            return
        }

         // MARK:-  check user exist or not

        DatabaseManager.shared.userExist(with: email.flatEmail()) { [weak self] isExist in
            if isExist{
                self?.alertRegistrationError(message: "User already exist")
                return
            }

            // MARK:-  Firebase insert user
            DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email.flatEmail()))

            // MARK:-  Firebase create user

            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard let user = result?.user, error == nil else {
                    return
                }

                print(user)
                strongSelf.navigationController?.dismiss(animated: true)
            }
        }
    }

    @objc private func changeImage(){
        print("change image called")
        presentationPhotoActionSheet()
    }

    private func alertRegistrationError(message:String = "Please enter all information" ){
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
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

        firstNameField.frame = CGRect(x: 30, y: imageView.bottom + 10, width: scrollView.width - 60, height: 52)
        lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom + 10, width: scrollView.width - 60, height: 52)
        emailField.frame = CGRect(x:  30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x:  30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        registerButton.frame = CGRect(x:  30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
    }
}

extension RegistrationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField{
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            validateField()
        }
        return true
    }
}

extension RegistrationViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func presentationPhotoActionSheet(){
        let actionSheet = UIAlertController(title: "",
                                            message: "How would you like to choose a photo", preferredStyle:.actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default,handler: { _ in
            self.openCamera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default,handler: { _ in
            self.openPhotoLibrary()
        }))
        present(actionSheet, animated: true)
    }

    func openCamera(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.title = "Take Profile Photo"
        present(imagePicker, animated: true)
    }

    func openPhotoLibrary(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.title = "Take Profile Photo"
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        print(info)
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
