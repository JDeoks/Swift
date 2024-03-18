//
//  NetworkManager.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchPosts(completion: @escaping (Result<[PostModel], NetworkError>) -> Void)  {
        print("\(type(of: self)) - \(#function)")
        
        let endPointStr = "https://koreanjson.com/posts"
        
        guard let url = URL(string: endPointStr) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                // error를 NetworkError로 전부 매핑하지 못하면 정보가 손실될 것 같은데...\
                // 커스텀 에러타입을 만드는게 좋은건가...?
                completion(.failure(.invalidTask))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let posts: [PostModel]? = self.decodeModel(data: data)
            
            guard let posts = posts else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(posts))
        }
        
        task.resume()
        
    }
    
    func fetchUsers(completion: @escaping (Result<[UserModel], NetworkError>) -> Void)  {
        print("\(type(of: self)) - \(#function)")
        
        let endPointStr = "https://koreanjson.com/users"
        
        guard let url = URL(string: endPointStr) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                // error를 NetworkError로 전부 매핑하지 못하면 정보가 손실될 것 같은데...\
                // 커스텀 에러타입을 만드는게 좋은건가...?
                completion(.failure(.invalidTask))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let users: [UserModel]? = self.decodeModel(data: data)
            
            guard let users = users else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(users))
        }
        
        task.resume()
        
    }
    
    func fetch<T: Codable>(type: RequestType, completion: @escaping (Result<[T], NetworkError>) -> () ) {
        
        guard let endPoint = URL(string: type.endPointStr) else {
            return
        }

        let task = URLSession.shared.dataTask(with: endPoint) { data, response, error in
            if let _ = error {
                // error를 NetworkError로 전부 매핑하지 못하면 정보가 손실될 것 같은데...\
                // 커스텀 에러타입을 만드는게 좋은건가...?
                completion(.failure(.invalidTask))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            let decodedResponse: [T]? = self.decodeModel(data: data)
            
            guard let decodedResponse = decodedResponse else {
                completion(.failure(.invalidData))
                return
            }
            
            completion(.success(decodedResponse))
        }
        
        task.resume()
        
    }
    
    func decodeModel<T: Codable>(data: Data) -> [T]? {
        do {
            let posts = try JSONDecoder().decode([T].self, from: data)
            return posts
        } catch {
            return nil
        }
    }
}

enum RequestType {
    case post
    case user
    
    var endPointStr: String {
        switch self {
        case .post:
            "https://koreanjson.com/posts"
        case .user:
            "https://koreanjson.com/users"
        }
    }
}
