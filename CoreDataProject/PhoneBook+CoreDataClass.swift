//
//  PhoneBook+CoreDataClass.swift
//  CoreDataProject
//
//  Created by 박승환 on 7/9/24.
//
//

import Foundation
import CoreData

@objc(PhoneBook)
public class PhoneBook: NSManagedObject {
    public static let className = "PhoneBook"
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
    }
}
