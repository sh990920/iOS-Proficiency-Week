//
//  ViewController.swift
//  URLSessionProject
//
//  Created by 박승환 on 7/10/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // 서버에서 데이터를 불러오는 메서드
    private func fetchData() {
        
        guard let url = URL(string: "https://reqres.in/api/users/1") else {
            print("URL이 잘못되었습니다.")
            return
        }
        
        // URLRequest 설정
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        // json 데이터 형식임을 나타냄
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, response, error) in
            // http 통신을 하면 response 안에 status code가 함께 오는데, 200번대가 성공을 했다는 것을 의미
            let successRange: Range = (200..<300)
            
            guard let data, error == nil else { return }
            
            if let response = response as? HTTPURLResponse {
                print("status code \(response.statusCode)")
                
                if successRange.contains(response.statusCode) {
                    guard let userInfo: ResponseData = try? JSONDecoder().decode(ResponseData.self, from: data) else { return }
                    
                    print("userInfo: \(userInfo)")
                } else {
                    print("요청 실패")
                }
            }
        }.resume()
        
    }
    

}

struct UserData: Codable {
    let id: Int
    let email: String
    let firstName: String
    let lastName: String
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct SupportData: Codable {
    let url: URL
    let text: String
}

struct ResponseData: Codable {
    let data: UserData
    let support: SupportData
}
