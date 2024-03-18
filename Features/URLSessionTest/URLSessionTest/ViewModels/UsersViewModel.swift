//
//  UsersViewModel.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/15/24.
//

import Foundation
import RxSwift

class UsersViewModel {
    
    var users: [UserModel] = []
    
    let fetchUsersDone = PublishSubject<Bool>()
    
    func fetchUsers() {
        print("\(type(of: self)) - \(#function)")

        NetworkManager.shared.fetch(type: .user) { (result: Result<[UserModel], NetworkError>) in
            switch result {
            case .success(let users):
                self.users = users
                self.fetchUsersDone.onNext(true)
                
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
