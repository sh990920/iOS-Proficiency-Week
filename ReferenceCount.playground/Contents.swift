import UIKit

class MyClass {
    init() {
        print("MyClass 생성")
    }
    
    deinit {
        print("MyClass 소멸")
    }
}

// RC = 1
var myClass: MyClass? = MyClass()

// RC = 2
var myClass2 = myClass

// RC = 2 - 1 = 1
myClass = nil

// RC = 1 - 1 = 0
myClass2 = nil


// 클로저의 캡쳐링
class People {
    let mbti = "ISTP"
    init() {
        print("클래스 생성")
    }
    deinit {
        print("클래스 소멸")
    }
}

// people RC = 1
var people: People? = People()

// 클로저 내부에서 people 캡쳐, RC 1증가. people RC -> 1 + 1 = 2
//let printMBTI: () -> () = {[people] in
//    guard let people else { return }
//    print("people's MBTI = \(people.mbti)")
//}

// weak 키워드로 약참조를 하여 RC가 증가하지 않음
let printMBTI: () -> () = {[weak people] in
    guard let people else { return }
    print("people's MBTI = \(people.mbti)")
}

printMBTI()

// people RC -> 2 - 1 = 1
people = nil

// 순환 참조
class Person {
    var pet: Dog?
    init() {
        print("Person 클래스 생성")
    }
    deinit {
        print("Person 클래스 소멸")
    }
}

class Dog {
    var owner: Person?
    init() {
        print("Dog 클래스 생성")
    }
    deinit {
        print("Dog 클래스 소멸")
    }
}

// person RC = 1
var person: Person? = Person()
// dog RC = 1
var dog: Dog? = Dog()

// dog RC = 2
person?.pet = dog
// person RC = 2
dog?.owner = person

// person RC = 1
person = nil
// dog RC = 1
dog = nil
