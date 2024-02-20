//
//  TodoTextViewTableViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/20/24.
//

import UIKit
import SnapKit

class TodoTextViewTableViewCell: UITableViewCell {

    lazy var userTextView = {
        let view = UITextView()
        view.text = "메모"
        view.textColor = .lightGray
        view.font = .boldSystemFont(ofSize: 16)
        view.delegate = self
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

extension TodoTextViewTableViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if userTextView.textColor == .lightGray {
            userTextView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if userTextView.text.isEmpty {
            userTextView.text = "메모"
            userTextView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textViewCallBack?(textView.text!)
    }
}
