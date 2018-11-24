//
//  LoginController+Constraints.swift
//  Sole purpose of this file is to divide UI design from Logic
//  gameofchats
//
//  Created by 2x2 on 11/24/18.
//  Copyright © 2018 2x2. All rights reserved.
//

import UIKit

extension LoginController{
    /*
     Constraints oveerrirde functions for subviews gose here
     */
    
    static var inputContainerViewHeightAncor: NSLayoutConstraint?
    static var nameTextFieldHeightAnchor: NSLayoutConstraint?
    
    
    func loadPageUI() {
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
        LoginController.inputContainerViewHeightAncor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
        LoginController.inputContainerViewHeightAncor?.isActive = true
        
        inputsContainerView.addSubview(nameTextField)
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(passwordTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: 0).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: -12).isActive = true
        LoginController.nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalToConstant: 49)
        LoginController.nameTextFieldHeightAnchor?.isActive = true
        
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
}
