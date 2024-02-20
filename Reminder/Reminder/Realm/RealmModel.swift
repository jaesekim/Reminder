//
//  RealmModel.swift
//  Reminder
//
//  Created by 김재석 on 2/16/24.
//

import Foundation
import RealmSwift

class ReminderTable: Object {
    
    convenience init(title: String, memo: String? = nil, createDate: Date, expireDate: String? = nil, tag: String? = nil, priority: Int? = nil) {
        self.init()
        self.title = title
        self.memo = memo
        self.createDate = createDate
        self.expireDate = expireDate
        self.tag = tag
        self.priority = priority
        self.done = false
    }
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var createDate: Date
    @Persisted var expireDate: String?
    @Persisted var tag: String?
    @Persisted var priority: Int?
    @Persisted var done: Bool
}
