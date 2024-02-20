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
    
    func showDiscardActionSheet() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )

        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        let destructive = UIAlertAction(
            title: "변경 사항 폐기",
            style: .destructive) { _ in
                self.dismiss(animated: true)
            }
        
        alert.addAction(cancel)
        alert.addAction(destructive)
        
        present(alert, animated: true)
    }
    
    func showToast(_ message: String) {
        view.makeToast(message)
    }
}
