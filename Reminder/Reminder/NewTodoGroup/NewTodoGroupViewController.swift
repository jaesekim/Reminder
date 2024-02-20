//
//  NewTodoGroupViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class NewTodoGroupViewController: BaseViewController {

    let textBackView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.backgroundColor = .systemGray6
        view.placeholder = "목록 이름"
        view.textAlignment = .center
        view.layer.cornerRadius = 8
        return view
    }()
    
    let repository = ReminderRepository()
    
    var delegate: sendDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureHierarchy() {
        view.addSubview(textBackView)
        textBackView.addSubview(titleTextField)
    }
    
    override func configureConstraints() {
        textBackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(200)
        }
        titleTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = "새로운 목록"
        setLeftBarButton()
        setRightBarButton()
    }
    
    func setLeftBarButton() {
        let leftButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonOnClick)
        )
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func cancelButtonOnClick() {
        showDiscardActionSheet()
    }
    
    func setRightBarButton() {
        let rightButton = UIBarButtonItem(
            title: "완료",
            style: .plain,
            target: self,
            action: #selector(doneButtonOnClick)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func doneButtonOnClick() {

        if let inputText = titleTextField.text {
            if inputText.count == 0 {
                showToast("목록 이름을 작성해 주세요")
            } else {
                
                let data = TodoGroup(
                    groupTitle: inputText, 
                    iconSystemName: "list.bullet",
                    regDate: Date()
                )
    
                repository.createItem(data)
                dismiss(animated: true)
                delegate?.reloadGroupTableView()
            }
        }
    }
}
