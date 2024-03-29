//
//  MainViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit
import RealmSwift

protocol sendDataDelegate {
    func reloadGroupTableView()
    func reloadTotalTodo()
}

class MainViewController: BaseViewController {
    
    enum ReminderList: Int, CaseIterable {
        case today
        case plan
        case total
        case flag
        case done
        
        var categoryTitle: String {
            switch self {
            case .today:
                return "오늘"
            case .plan:
                return "예정"
            case .total:
                return "전체"
            case .flag:
                return "깃발"
            case .done:
                return "완료됨"
            }
        }
        
        var categoryIcon: String {
            switch self {
            case .today:
                return "calendar.circle.fill"
            case .plan:
                return "calendar.circle"
            case .total:
                return "tray.circle"
            case .flag:
                return "flag.circle.fill"
            case .done:
                return "checkmark.circle.fill"
            }
        }
        
        var iconColor: UIColor {
            switch self {
            case .today:
                return .systemBlue
            case .plan:
                return .systemRed
            case .total:
                return .black
            case .flag:
                return .systemOrange
            case .done:
                return .systemGray2
            }
        }
    }
    
    var todoGroup: Results<TodoGroup>!
    
    var totalReminder: Results<ReminderTable>! {
        didSet {
            mainCollectionView.reloadData()
        }
    }
    
    // 껍데기 TableView
    lazy var outlineTableView = {
        let view = UITableView()
        return view
    }()
    
    let totalLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 28)
        view.text = "전체"
        return view
    }()

    lazy var mainCollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: MainViewController.configureCollectionViewLayout()
        )
        view.backgroundColor = .clear
        view.register(
            MainCollectionViewCell.self,
            forCellWithReuseIdentifier: "MainCollectionViewCell"
        )
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    lazy var groupTableView = {
        let view = UITableView(
            frame: .zero,
            style: .insetGrouped
        )
        view.rowHeight = 40
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        view.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "GroupTableViewCell"
        )
        return view
    }()

    var doneCount = 0
    let repository = ReminderRepository()
    let toolbar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalReminder = repository.readItem(type: ReminderTable.self)
        todoGroup = repository.readItem(type: TodoGroup.self)
    
        for item in totalReminder {
            if item.done {
                doneCount += 1
            }
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(todoCountReceivedNotificationObserver),
            name: NSNotification.Name("todoCountReceived"),
            object: nil
        )

        designToolbar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        totalReminder = repository.readItem(type: ReminderTable.self)
        todoGroup = repository.readItem(type: TodoGroup.self)
        print(todoGroup)
    }
    
    @objc func todoCountReceivedNotificationObserver(
        notification: NSNotification
    ) {
        if let value = notification.userInfo?["count"] as? Int {
            print(value)
            doneCount = value
        }
    }
    override func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(mainCollectionView)
        view.addSubview(groupTableView)
        view.addSubview(toolbar)
    }

    override func configureView() {
        super.configureView()

        setRightBarButton()

        let backBarButtonItem = UIBarButtonItem(
            title: "목록",
            style: .plain,
            target: self,
            action: nil
        )
        navigationItem.backBarButtonItem = backBarButtonItem

        toolbar.backgroundColor = .white.withAlphaComponent(0.9)
        toolbar.barTintColor = .white.withAlphaComponent(0.9)
        toolbar.clipsToBounds = false
    }
    
    override func configureConstraints() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
        mainCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(totalLabel.snp.bottom).offset(12)
            make.height.equalTo(UIScreen.main.bounds.width - 80)
        }
        groupTableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(mainCollectionView.snp.bottom).offset(4)
            make.bottom.equalTo(toolbar.snp.top)
        }
        toolbar.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func designToolbar() {
        var items: [UIBarButtonItem] = []
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )

        let toolbarItem1 = UIBarButtonItem(
            title: "새로운 미리알림",
            image: UIImage(systemName: "plus.circle.fill"),
            target: self,
            action: #selector(newTodoClicked)
        )
        
        let toolbarItem2 = UIBarButtonItem(
            title: "새로운 미리알림",
            style: .plain,
            target: self,
            action: #selector(newTodoClicked)
        )
        
        let toolbarItem3 = UIBarButtonItem(
            title: "목록추가",
            style: .plain,
            target: self,
            action: #selector(newTodoGroupClicked)
        )
        
        items.append(toolbarItem1)
        items.append(toolbarItem2)
        items.append(flexibleSpace)
        items.append(toolbarItem3)
        
        toolbar.setItems(items, animated: true)
    }
    
    @objc func newTodoClicked() {
        let vc = TodoViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }
    
    @objc func newTodoGroupClicked() {
        let vc = NewTodoGroupViewController()
        vc.delegate = self
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - 60) / 2
        layout.itemSize = CGSize(
            width: width,
            height: width * 0.5
        )
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        layout.scrollDirection = .vertical
        return layout
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
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return ReminderList.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MainCollectionViewCell", 
            for: indexPath
        ) as! MainCollectionViewCell

        let target = ReminderList.allCases[indexPath.row]

        cell.iconImage.image = UIImage(systemName: target.categoryIcon)
        cell.iconImage.tintColor = target.iconColor
        cell.countLabel.text = "0"

        if indexPath.row == 2 {
            cell.countLabel.text = "\(totalReminder.count)"
            // set 만들기
        } else if indexPath.row == 4 {
            cell.countLabel.text = "\(doneCount)"
        }
        cell.categoryLabel.text = target.categoryTitle

        return cell
    }
    
    // 눌렀을 때 다른 페이지로 넘어가게 만들기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentIdx = indexPath.row
        let vc = TodoListViewController()
    
        if currentIdx == 2 {
            
            vc.menuTitleLabel.text = ReminderList.allCases[currentIdx].categoryTitle
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return todoGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "GroupTableViewCell"
        ) else { return UITableViewCell() }

        let target = todoGroup[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: target.iconSystemName)
        cell.textLabel?.text = target.groupTitle
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = TodoListViewController()
        vc.menuTitleLabel.text = todoGroup[indexPath.row].groupTitle
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // Allow Sliding
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            repository.deleteItem(todoGroup[indexPath.row])
            groupTableView.reloadData()
        }
    }
}


extension MainViewController: sendDataDelegate {
    func reloadGroupTableView() {
        todoGroup = repository.readItem(type: TodoGroup.self)
        groupTableView.reloadData()
    }
    
    func reloadTotalTodo() {
        totalReminder = repository.readItem(type: ReminderTable.self)
        mainCollectionView.reloadData()
    }
}
