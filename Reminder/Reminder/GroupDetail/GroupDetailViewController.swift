//
//  GroupDetailViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/20/24.
//

import UIKit
import SnapKit
import RealmSwift

class GroupDetailViewController: BaseViewController {

    let menuTitleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 28)
        return view
    }()

    let todoCountLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        view.font = .systemFont(ofSize: 16)
        view.text = "0개 완료됨"
        return view
    }()

    let deleteTextButton = {
        let view = UIButton()
        view.setTitle("지우기", for: .normal)
        view.setTitleColor(.systemBlue, for: .normal)
        view.addTarget(
            self,
            action: #selector(deleteTextButtonOnClick),
            for: .touchUpInside
        )
        return view
    }()

    lazy var todoListTableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        
        return view
    }()
    
    var main: TodoGroup!
    
    var todoList: Results<ReminderTable>!

    var todoCount = 0

    let repository = ReminderRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoList = repository.readItem(type: ReminderTable.self)
        
        for item in todoList {
            if item.done {
                todoCount += 1
            }
        }
        todoCountLabel.text = "\(todoCount)개 완료됨"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 화면 들어올 때마다 view 업데이트
        todoListTableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("todolist:", todoCount)
        // post
        NotificationCenter.default.post(
            name: NSNotification.Name("todoCountReceived"),
            object: nil,
            userInfo: [
                "count" : todoCount
            ]
        )
    }
    override func configureHierarchy() {
        view.addSubview(menuTitleLabel)
        view.addSubview(todoCountLabel)
        view.addSubview(deleteTextButton)
        view.addSubview(todoListTableView)
    }

    override func configureConstraints() {
        menuTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        todoCountLabel.snp.makeConstraints { make in
            make.top.equalTo(menuTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(24)
            make.width.equalTo(100)
            make.leading.equalToSuperview().inset(24)
        }
        deleteTextButton.snp.makeConstraints { make in
            make.top.equalTo(menuTitleLabel.snp.bottom).offset(8)
            make.centerY.equalTo(todoCountLabel)
            make.height.equalTo(24)
            make.width.equalTo(100)
            make.trailing.equalToSuperview()
        }
        todoListTableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(todoCountLabel.snp.bottom).offset(8)
        }
    }

    override func configureView() {
        super.configureView()
        setRightBarButton()
    }
    
    func setRightBarButton() {
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle"),
            style: .plain,
            target: self,
            action: #selector(sortButtonClicked)
        )
        
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func sortButtonClicked() {
        
    }
    
    @objc func deleteTextButtonOnClick() {
        for item in todoList {
            if item.done {
                repository.deleteItem(item)
            }
        }
        todoListTableView.reloadData()
        todoCount = 0
        todoCountLabel.text = "0개 완료됨"
    }
}

extension GroupDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
