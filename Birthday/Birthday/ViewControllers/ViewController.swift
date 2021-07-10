//
//  ViewController.swift
//  Birthday
//
//  Created by Клим on 04.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var enterButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterButtonOutlet.layer.cornerRadius = 10
    }
    
    @IBAction func enterButton(_ sender: Any) {
        enter()
    }
    
    @IBAction func hiddenButton() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    private func enter() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if email.isEmpty {
            showAlert(title: "Неверный логин", message: "Введите логин")
        } else if password.isEmpty {
            showAlert(title: "Неверный пароль", message: "Введите пароль")
        } else {
            performSegue(withIdentifier: "profile", sender: nil)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
