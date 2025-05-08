//
//  ViewController.swift
//  Login
//
//  Created by 이지훈 on 5/8/25.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var idField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    
    @IBAction func login(_ sender: Any) {
        let id = idField.text!
        let password = passwordField.text!
        
//        if id.isEmpty || password.isEmpty {
//            print("게정을 입력하세요")
//            return
//        }
//
        
        //Early exit
        //코드 중첩 방지
        guard !id.isEmpty && !password.isEmpty else{
            print("계정을 입력하세요")
            return
        }
        
        
        if id == "1234" && password == "1234" {
            resultLabel.text = "로그인 성공"
        }
        else {
            resultLabel.text = "아이디가 일치하지 않습니다"
        }
        
       
        
        
//        resultLabel.text = id == "1234" && password == "1234" ? "로그인 성공" : "로그인 실패"
        
        
    }
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

