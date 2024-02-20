//
//  ReminderRepository.swift
//  Reminder
//
//  Created by 김재석 on 2/17/24.
//

import Foundation
import RealmSwift

final class ReminderRepository {
    
    private let realm = try! Realm()
    
    func createItem<T: Object>(_ item: T) {
        do {
            try realm.write {
                realm.add(item)
                print(realm.configuration.fileURL)
            }
        } catch {
            
        }
    }
    
    func readItem<T: Object>(type: T.Type) -> Results<T> {
        return realm.objects(T.self)
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
    
    func deleteItem<T: Object>(_ item: T) {
        do {
            try realm.write{
                realm.delete(item)
            }
        } catch {
            print(error)
        }
    }
}
