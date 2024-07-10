import UIKit

struct PhoneBook: Codable {
    let name: String
    let phoneNumber: String
}

// string 으로 json 모양의 데이터를 생성
let jsonString = """
[
    {
        "name": "User1",
        "phoneNumber": "010-1111-2222"
    },
    {
        "name": "User2",
        "phoneNumber": "010-3333-4444"
    },
    {
        "name": "User3",
        "phoneNumber": "010-5555-6666"
    }
]
"""

// jsonString 을 통해서 jsonData 를 생성
let jsonData = jsonString.data(using: .utf8)!

// Json 디코더
let jsonDecoder = JSONDecoder()

do {
    let phoneBooks = try jsonDecoder.decode([PhoneBook].self, from: jsonData)
    for phoneBook in phoneBooks {
        print("name: \(phoneBook.name), phoneNumber: \(phoneBook.phoneNumber)")
    }
} catch {
    print("Json 디코딩 실패")
}
