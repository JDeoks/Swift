//
//  PostsViewModel.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import Foundation
import RxSwift

class PostsViewModel {
    
    var posts: [PostModel] = []
    
    let fetchPostsDone = PublishSubject<Bool>()
    let serverError = PublishSubject<NetworkError>()
    
    func fetchPosts() {
        print("\(type(of: self)) - \(#function)")
        
        NetworkManager.shared.fetch(type: .post) { (result: Result<[PostModel], NetworkError>) in
            switch result {
            case .success(let posts):
                self.posts = posts
                self.fetchPostsDone.onNext(true)
                
            case .failure(let error):
                switch error {
                case .invalidTask:
                    print(error.errorMessage)
                case .invalidURL:
                    print(error.errorMessage)
                case .badConnection:
                    print(error.errorMessage)
                case .invalidResponse:
                    print(error.errorMessage)
                case .invalidData:
                    print(error.errorMessage)
                }
            }
        }
        
    }
    
}
