//
//  ViewController.swift
//  CoreDataProject
//
//  Created by 박승환 on 7/9/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // CoreData
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.container = appDelegate.persistentContainer
////        createData(name: "TestUser3", phoneNumber: "010-2222-3333")
////        updateData(currentName: "TestUser2", updateName: "TestUser4")
////        deleteData(name: "TestUser4")
////        
////        readAllData()
//        
//        // CRUD
//        // Create
//        createData(name: "TestUser5", phoneNumber: "010-5555-6666")
//        // Update
//        updateData(currentName: "TestUser5", updateName: "User5")
//        // Read
//        readAllData()
//        // Delete
//        deleteData(name: "TestUser1")
//        
//        readAllData()
        
        // UserDefaults
        
        // Create
        UserDefaults.standard.set("010-1111-2222", forKey: "phoneNumber")
        
        // Read
//        guard let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber1") else {
//            print("저장된 전화번호가 없습니다.")
//            return
//        }
        
        // 원시타입만 가능
        // struct 나 class 는 json 파일로 인코딩 한 이후 사용을 해야 한다.
        
        // Update
        UserDefaults.standard.set("010-3333-4444", forKey: "phoneNumber")
        
        let phoneNumber = UserDefaults.standard.string(forKey: "phoneNumber")
        
        print("저장된 전화번호 : \(phoneNumber)")
        
        // Delete
        UserDefaults.standard.removeObject(forKey: "phoneNumber")
        
        print("저장된 전화번호가 남아있는지 확인 : \(phoneNumber)")
        
    }

    // CoreDataProject 에 데이터 Create
    func createData(name: String, phoneNumber: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: PhoneBook.className, in: self.container.viewContext) else { return }
        let newPhoneBook = NSManagedObject(entity: entity, insertInto: self.container.viewContext)
        newPhoneBook.setValue(name, forKey: PhoneBook.Key.name)
        newPhoneBook.setValue(phoneNumber, forKey: PhoneBook.Key.phoneNumber)
        
        do {
            try self.container.viewContext.save()
            print("문맥 저장 성공")
        } catch {
            print("문맥 저장 실패")
        }
    }
    
    // CoreDataProject 에서 데이더 Read
    func readAllData() {
        do {
            let phoneBooks = try self.container.viewContext.fetch(PhoneBook.fetchRequest())
            
            for phoneBook in phoneBooks as [NSManagedObject] {
                if let name = phoneBook.value(forKey: PhoneBook.Key.name) as? String,
                   let phoneNumber = phoneBook.value(forKey: PhoneBook.Key.phoneNumber) as? String {
                    print("name : \(name), phoneNumber : \(phoneNumber)")
                }
            }
            
        } catch {
            print("데이터 읽기 실패")
        }
    }
    
    // CoreDataProject 에서 데이더 Update
    func updateData(currentName: String, updateName: String) {
        
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", currentName)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                // data 중 name 의 값을 updateName 으로 update 한다
                data.setValue(updateName, forKey: PhoneBook.Key.name)
            }
            
            try self.container.viewContext.save()
            
            print("데이터 수정 성공")
        } catch {
            print("데이터 수정  실패")
        }
        
    }
    
    // CoreDataProject 에서 데이터 Delete
    func deleteData(name: String) {
        let fetchRequest = PhoneBook.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let result = try self.container.viewContext.fetch(fetchRequest)
            
            for data in result as [NSManagedObject] {
                self.container.viewContext.delete(data)
            }
            
            try self.container.viewContext.save()
            
            print("데이터 삭제 성공")
            
        } catch {
            print("데이터 삭제 실패")
        }
        
    }
    

}

