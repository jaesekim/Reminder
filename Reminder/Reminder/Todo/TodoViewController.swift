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

    enum AddList: Int, CaseIterable {
        case inputText
        case endDate
        case tag
        case priority
        case addImage
        case selectedImage
        
        var menu: String {
            switch self {
            case .inputText:
                return "제목"
            case .endDate:
                return "마감일"
            case .tag:
                return "태그"
            case .priority:
                return "우선순위"
            case .addImage:
                return "이미지 추가"
            case .selectedImage:
                return "선택한 이미지"
            }
        }
    }
    
    lazy var todoTableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(
            TodoTextFieldTableViewCell.self,
            forCellReuseIdentifier: "TodoTextFieldTableViewCell"
        )
        view.register(
            TodoTextViewTableViewCell.self,
            forCellReuseIdentifier: "TodoTextViewTableViewCell"
        )
        view.register(
            TodoTableViewCell.self,
            forCellReuseIdentifier: "TodoTableViewCell"
        )
        view.register(
            TodoImageTableViewCell.self,
            forCellReuseIdentifier: "TodoImageTableViewCell"
        )
        view.backgroundColor = .clear
//        view.rowHeight = 40
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    let selectedImageView = {
        let view = UIImageView(frame: .zero)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()

    var detailTextList = ["", "", "", ""] {
        didSet {
            todoTableView.reloadData()
        }
    }
    
    var userDataTitle: String = ""
    var userDataMemo: String?
    var userDataExpireDate: String?
    var userDataTag: String?
    var userDataPriority: Int?
    
    let repository = ReminderRepository()
    
    var delegate: sendDataDelegate?

    var addDoneCount: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        addDoneCount?()
    }
    
    override func configureHierarchy() {
        view.addSubview(todoTableView)
        view.addSubview(selectedImageView)
    }

    override func configureView() {
        super.configureView()
        
        setRightBarButton()
        
        navigationItem.title = "새로운 미리알림"
    }
    
    override func configureConstraints() {
        todoTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    @objc func addButtonClicked() {

        if userDataTitle.count != 0 {
            
            let data = ReminderTable(
                title: userDataTitle,
                memo: userDataMemo,
                createDate: Date(),
                expireDate: userDataExpireDate,
                tag: userDataTag,
                priority: userDataPriority
            )

            repository.createItem(data)
            delegate?.reloadTotalTodo()

            dismiss(animated: true)
        } else {
            showToast("제목을 입력해 주세요")
        }
    }
    
    func setRightBarButton() {
        let rightButton = UIBarButtonItem(
            title: "추가",
            style: .plain,
            target: self,
            action: #selector(addButtonClicked)
        )

        navigationItem.rightBarButtonItem = rightButton
    }

}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "TodoTextFieldTableViewCell",
                    for: indexPath
                ) as! TodoTextFieldTableViewCell
                cell.textFieldCallBack = { text in
                    self.userDataTitle = text
                }
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "TodoTextViewTableViewCell",
                    for: indexPath
                ) as! TodoTextViewTableViewCell
                cell.textViewCallBack = { text in
                    self.userDataMemo = text
                }

                return cell
            }
        } else if indexPath.section == 5 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TodoImageTableViewCell",
                for: indexPath
            ) as! TodoImageTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TodoTableViewCell",
                for: indexPath
            ) as! TodoTableViewCell
            cell.titleLabel.text = AddList.allCases[indexPath.section].menu
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section != 5 {
            return 40
        } else if indexPath.row == 0 && indexPath.section == 5 {
            return UIScreen.main.bounds.width
        } else {
            return 80
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let curIdx = indexPath.section
//        if curIdx == 0 {
//            let vc = EndDateViewController()
//            vc.dateCallBack = { date in
//                // callback 인자 두 개 받는 법?
//                self.detailTextList[indexPath.section] = date
//                self.userDataExpireDate = date
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        } else if curIdx == 1 {
//            let vc = AddTagViewController()
//            vc.tagCallBack = { tag in
//                self.detailTextList[indexPath.section] = tag
//                self.userDataTag = tag
//            }
//            navigationController?.pushViewController(vc, animated: true)
//        } else if curIdx == 2 {
//            let vc = PriorityViewController()
//            
//            navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = AddImageViewController()
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 5 {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
