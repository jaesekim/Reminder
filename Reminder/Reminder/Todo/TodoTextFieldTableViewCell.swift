//
//  TodoTextTableViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/19/24.
//

import UIKit
import SnapKit

class TodoTextFieldTableViewCell: UITableViewCell {
    
    lazy var userTextField = {
        let view = UITextField()
        view.placeholder = "제목"
        view.addTarget(
            self,
            action: #selector(textFieldOnChange),
            for: .editingChanged
        )
        return view
    }()
    
    var textFieldCallBack: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(userTextField)
    }

    func configureConstraints() {
        userTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(2)
        }
    }

    func configureView() {
        backgroundColor = .white
    }
    
    @objc func textFieldOnChange() {
        textFieldCallBack?(userTextField.text!)
    }
}


