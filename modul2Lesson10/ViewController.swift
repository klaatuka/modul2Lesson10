//
//  ViewController.swift
//  modul2Lesson10
//
//  Created by Давид Узунян on 13.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var alert: UIAlertController = {
        
        let alert = UIAlertController(title: "Alert", message: "message", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Email"
            textField.keyboardType = .emailAddress
            textField.textColor = .green
            textField.font = UIFont.systemFont(ofSize: 20, weight: .black)
        }
        alert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
            textField.textColor = .green
            textField.font = UIFont.systemFont(ofSize: 20, weight: .black)
        }

        let okBtn = UIAlertAction(title: "Ok", style: .default) { _ in
            print(alert.textFields?[0].text)
            
        }
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("cancel")
        }
        
        let distructiveBtn = UIAlertAction(title: "Cancel2", style: .destructive) { _ in
            print("distr")
        }
        alert.addAction(okBtn)
        alert.addAction(cancelBtn)
        alert.addAction(distructiveBtn)

        return alert
    }()
   
    lazy var btn: UIButton = {
        $0.center = view.center
        $0.frame.size = CGSize(width: 100, height: 50)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.setTitle("Alert", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        return $0
    }(UIButton(primaryAction: action))
    
    lazy var action = UIAction { _ in
        self.present(self.alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btn)
    }


}

