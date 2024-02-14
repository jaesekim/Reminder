//
//  MainViewController.swift
//  Reminder
//
//  Created by 김재석 on 2/14/24.
//

import UIKit
import SnapKit

class MainViewController: BaseViewController {

    let toolbar = UIToolbar()

    override func viewDidLoad() {
        super.viewDidLoad()

        designToolbar()
    }
    
    override func configureHierarchy() {
        view.addSubview(toolbar)
    }

    override func configureView() {
        super.configureView()
        toolbar.barTintColor = .white
        toolbar.clipsToBounds = true
    }
    
    override func configureConstraints() {
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
            action: nil
        )
        
        items.append(toolbarItem1)
        items.append(toolbarItem2)
        items.append(flexibleSpace)
        items.append(toolbarItem3)
        
        toolbar.setItems(items, animated: true)
    }
    
    @objc func newTodoClicked() {
        let vc = TodoViewController()
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true)
    }

}
