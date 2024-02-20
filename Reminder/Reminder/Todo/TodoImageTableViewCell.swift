//
//  TodoImageTableViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/19/24.
//

import UIKit

class TodoImageTableViewCell: UITableViewCell {

    lazy var userTextView = {
        let view = UITextView()
        view.text = "메모"
        view.textColor = .lightGray
        view.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    var textViewCallBack: ((String) -> Void)?
    
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
        contentView.addSubview(userTextView)
    }

    func configureConstraints() {
        userTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(80)
        }
    }

    func configureView() {
        backgroundColor = .white
    }

}
