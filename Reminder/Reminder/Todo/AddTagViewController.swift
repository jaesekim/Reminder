//
//  AddTagViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit

class AddTagViewController: BaseViewController {

    let tagTextField = UITextField()
    var tagCallBack: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tagCallBack?(tagTextField.text!)
        print("out!!!")
        print(tagTextField.text!)
    }
    
    override func configureHierarchy() {
        view.addSubview(tagTextField)
    }

    override func configureView() {
        super.configureView()

        tagTextField.placeholder = "태그를 입력해 주세요"
        tagTextField.keyboardType = .default
    }
    
    override func configureConstraints() {
        tagTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }


}
