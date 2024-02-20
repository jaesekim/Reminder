//
//  BaseViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import Toast

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureView()
        configureConstraints()
    }

    func configureHierarchy() {
        print(#function)
    }

    func configureView() {
        view.backgroundColor = .systemGray5
        print(#function)
    }

    func configureConstraints() {
        print(#function)
    }
    
    func showToast(_ message: String) {
        view.makeToast(message)
    }
}
