//
//  EnterEmailViewController.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/05/30.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        emailTextField.becomeFirstResponder() //커서가 이메일텍스트필드로 바로 이동.  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func tapNextButton(_ sender: UIButton) {
        //파이어베이스 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                switch code{
                case 17007: //이미 가입한 계정일 때,
                    self.loginUser(withEmail: email, password: password)
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                   }
                }else {
                    self.showMainController()
                }
            
            
        }
        
    }
    
    private func showMainController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let tabBarController = storyboard.instantiateViewController(identifier:"tabBarController")
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController?.show(tabBarController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else {return}
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            }else {
                self.showMainController()
            }
        }
    }
}

extension EnterEmailViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
