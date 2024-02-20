//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/19/24.
//

import UIKit
import SnapKit

class TodoTableViewCell: UITableViewCell {

    let titleLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        return view
    }()

    let detailLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.textAlignment = .right
        return view
    }()

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
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
    }
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.leading.equalToSuperview().inset(8)
        }
        detailLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureView() {
        backgroundColor = .white
    }
}
