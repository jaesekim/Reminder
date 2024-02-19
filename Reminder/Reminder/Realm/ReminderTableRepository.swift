//
//  ReminderTableRepository.swift
//  Reminder
//
//  Created by 김재석 on 2/17/24.
//

import Foundation
import RealmSwift

final class ReminderTableRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ item: ReminderTable) {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            print(error)
        }
    }
    
    func readItem() -> Results<ReminderTable> {
        return realm.objects(ReminderTable.self)
    }
    
    func updateDone(_ item: ReminderTable) {
        do {
            try realm.write{
                item.done.toggle()
            }
        } catch {
            print(error)
        }
    }
    
    func deleteItem(_ item: ReminderTable) {
        do {
            try realm.write{
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
