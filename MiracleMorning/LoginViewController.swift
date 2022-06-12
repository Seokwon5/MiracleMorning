//
//  LoginViewController.swift
//  MiracleMorning
//
//  Created by 이석원 on 2022/05/30.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
         
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationBar 숨기기
        navigationController?.navigationBar.isHidden = true
        

       
    }
    
    @IBAction func tapGoogleLoginButton(_ sender: UIButton) {
        //구글로 로그인
    }
    
    
    @IBAction func tapAppleLoginButton(_ sender: UIButton) {
        //애플로 로그인
    }
    
    
}
