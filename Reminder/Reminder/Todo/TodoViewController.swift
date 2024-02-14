//
//  TodoViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit

class TodoViewController: BaseViewController {

    let titleTextField = UITextField()
    let memotextField = UITextField()
    
    let addList = ["마감일", "태그", "우선순위", "이미지 추가"]
    var detailTextList = ["", "", "", ""] {
        didSet {
            todoTableView.reloadData()
        }
    }
    
    lazy var todoTableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.backgroundColor = .clear
        view.rowHeight = 40
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(titleTextField)
        view.addSubview(memotextField)
        view.addSubview(todoTableView)
    }

    override func configureView() {
        super.configureView()
        
        navigationItem.title = "새로운 미리알림"

        titleTextField.placeholder = "제목"
        memotextField.placeholder = "메모"
    }
    
    override func configureConstraints() {
        titleTextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        memotextField.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.top.equalTo(titleTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
        }
        
        todoTableView.snp.makeConstraints { make in
            make.top.equalTo(memotextField.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return addList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let curIdx = indexPath.section
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "todoCell")
        cell.textLabel?.text = addList[indexPath.section]
        cell.detailTextLabel?.text = detailTextList[indexPath.section]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .systemGray5
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let curIdx = indexPath.section
        if curIdx == 0 {
            let vc = EndDateViewController()
            vc.dateCallBack = { date in
                self.detailTextList[indexPath.section] = date
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if curIdx == 1 {
            let vc = AddTagViewController()
            vc.tagCallBack = { tag in
                self.detailTextList[indexPath.section] = tag
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if curIdx == 2 {
            let vc = PriorityViewController()
            
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = AddImageViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
