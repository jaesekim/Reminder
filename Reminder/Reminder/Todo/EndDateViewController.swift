//
//  EndDateViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit

class EndDateViewController: BaseViewController {

    let dateLabel = UILabel()
    let datePicker = UIDatePicker()
    
    var dateCallBack: ((String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dateCallBack?(dateLabel.text!)
    }
    
    override func configureHierarchy() {
        view.addSubview(dateLabel)
        view.addSubview(datePicker)
    }

    override func configureView() {
        super.configureView()
        
        dateLabel.text = dateFormatting(date: Date())
        dateLabel.textAlignment = .center
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(
            self, 
            action: #selector(dateOnChange),
            for: .valueChanged
        )
    }
    
    override func configureConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(48)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @objc func dateOnChange(_ sender: UIDatePicker) {
        dateLabel.text = dateFormatting(date: sender.date)
    }
    
    func dateFormatting(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"

        return formatter.string(from: date)
    }

}
