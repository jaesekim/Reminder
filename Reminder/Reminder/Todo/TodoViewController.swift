//
//  TodoViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

class TodoViewController: BaseViewController {

    let titleTextField = UITextField()
    let memotextField = UITextField()
    
    let addList = ["마감일", "태그", "우선순위", "이미지 추가"]
    var detailTextList = ["", "", "", ""] {
        didSet {
            todoTableView.reloadData()
        }
    }
    
    var userDataTitle: String?
    var userDataMemo: String?
    var userDataExpireDate: String?
    var userDataTag: String?
    var userDataPriority: Int?
    
    
    
    lazy var todoTableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "todoCell"
        )
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
        
        setRightBarButton()
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
    
    @objc func rightBarButtonClicked() {
        
        userDataTitle = titleTextField.text
        userDataMemo = memotextField.text

        if let userDataTitle = userDataTitle {
            
            let realm = try! Realm()
            print(realm.configuration.fileURL)
            let data = ReminderTable(
                title: userDataTitle,
                memo: userDataMemo,
                expireDate: userDataExpireDate,
                tag: userDataTag,
                priority: userDataPriority
            )
            
            try! realm.write {
                realm.add(data)
            }
        }
    }
    
    func setRightBarButton() {
        let rightButton = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonClicked)
        )

        navigationItem.rightBarButtonItem = rightButton
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
                // callback 인자 두 개 받는 법?
                self.detailTextList[indexPath.section] = date
                self.userDataExpireDate = date
            }
            navigationController?.pushViewController(vc, animated: true)
        } else if curIdx == 1 {
            let vc = AddTagViewController()
            vc.tagCallBack = { tag in
                self.detailTextList[indexPath.section] = tag
                self.userDataTag = tag
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
