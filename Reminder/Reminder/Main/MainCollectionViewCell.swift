//
//  MainCollectionViewCell.swift
//  Reminder
//
//  Created by 김재석 on 2/15/24.
//

import UIKit
import SnapKit

class MainCollectionViewCell: UICollectionViewCell {
    
    let iconImage = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let countLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.text = "0"
        return view
    }()
    
    let categoryLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .gray
        view.text = "TEST"
        return view
    }()
    
    let width = UIScreen.main.bounds.width / 2 - 60
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(iconImage)
        contentView.addSubview(countLabel)
        contentView.addSubview(categoryLabel)
    }
    func configureConstraints() {
        iconImage.snp.makeConstraints { make in
            make.width.height.equalTo(width / 4)
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().inset(8)
        }
        countLabel.snp.makeConstraints { make in
            make.width.height.equalTo(width / 4)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalTo(iconImage)
        }
        categoryLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(8)
            make.leading.equalTo(iconImage.snp.leading).offset(3.7)
            make.trailing.equalToSuperview().inset(12)
        }
    }
    func configureView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}
