//
//  LoginController.swift
//  gameofchats
//
//  Created by 2x2 on 11/11/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginController: UIViewController {
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Colors.loginRegBtn
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Colors.white, for: .normal)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(newUserRegistration), for: .touchUpInside)
        return button
    }()
    
    let nameTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Name"
        input.textColor = Colors.loginRegBtn
        input.setBottomBorder()
        return input
    }()
    
    let passwordTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Password"
        input.textColor = Colors.loginRegBtn
        input.isSecureTextEntry = true
        return input
    }()
    
    let emailTextField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Email"
        input.textColor = Colors.loginRegBtn
        input.setBottomBorder()
        return input
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wolf")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        return imageView
    }()
    
    let segmentedControlView: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Login", "Register"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.tintColor = Colors.white
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.white], for: UIControl.State.normal)
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.loginBgBlue], for: UIControl.State.selected)
        segment.selectedSegmentIndex = 1
        return segment
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.loginBgBlue
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(segmentedControlView)
        view.addSubview(profileImageView)
        
        setupInputContainerViewConstraints()
        setupLoginRegisterButtonConstraints()
        setupSegmentedControlView()
        setupProfileImageViewConstraints()
    }
    
    @objc func newUserRegistration(){
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
            else{
                print("Please enter valid form data")
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            if  error != nil {
                print("Error! : ", error! )
                return
            }
            
//            guard let user = authResult?.user else { return }
            guard let uid = authResult?.user.uid else {return}
            
            var ref: DatabaseReference!
            ref = Database.database().reference(fromURL: "https://gameofchats-lbta.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (writeError, ref) in
                if writeError != nil{
                    print("Error: Unable to register new user. ", writeError!)
                    return
                }
                
                print("New user was registered successfully")
            })
            

        }
    }
    
    
    /*
     Constraints oveerrirde functions for subviews gose here
     */
    
    func setupSegmentedControlView() {
        segmentedControlView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControlView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        segmentedControlView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        segmentedControlView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControlView.topAnchor.constraint(equalTo: segmentedControlView.topAnchor)
    }
    
    func setupProfileImageViewConstraints(){
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: segmentedControlView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 120).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }
    
    func setupInputContainerViewConstraints(){
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 49).isActive = true
        
        emailTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor, constant: 0).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 1).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: 0).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 49).isActive = true

        passwordTextField.leftAnchor.constraint(equalTo: emailTextField.leftAnchor, constant: 0).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 1).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: emailTextField.rightAnchor, constant: 0).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLoginRegisterButtonConstraints(){
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}


