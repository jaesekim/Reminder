//
//  BaseViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit

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
        view.backgroundColor = .white
        print(#function)
    }

    func configureConstraints() {
        print(#function)
    }
}
