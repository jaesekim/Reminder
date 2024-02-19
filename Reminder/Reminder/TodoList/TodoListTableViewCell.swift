//
//  TodoListTableViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/18/24.
//

import UIKit
import SnapKit

class TodoListTableViewCell: UITableViewCell {

    let doneButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "circle"), for: .normal)
        view.addTarget(
            self, 
            action: #selector(doneButtonOnClick),
            for: .touchUpInside
        )
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let memoLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 0
        return view
    }()

    var doneButtonCallBack: (() -> Void)?

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
        contentView.addSubview(doneButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
    }
    func configureConstraints() {
        doneButton.snp.makeConstraints { make in
            make.height.width.equalTo(28)
            make.centerY.equalToSuperview()
            make.leading.equalTo(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(doneButton.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
        memoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(doneButton.snp.trailing).offset(4)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(20)
        }
    }
    func configureView() {
        backgroundColor = .clear
    }
    
    @objc func doneButtonOnClick() {
        doneButtonCallBack?()
    }
    
}
