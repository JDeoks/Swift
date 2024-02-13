//
//  MainViewController.swift
//  Chat
//
//  Created by JDeoks on 12/8/23.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAnalytics
import RxSwift

class UsersViewController: UIViewController {

    var users: [UserModel] = []
    
    let fetchUsersDone = PublishSubject<Void>()
    let disposeBag = DisposeBag()

    @IBOutlet var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        bind()
        fetchUsersList()
    }
    
    func initUI() {
        usersTableView.dataSource = self
        usersTableView.delegate = self
        let friendsTableViewCell = UINib(nibName: "UsersTableViewCell", bundle: nil)
        usersTableView.register(friendsTableViewCell, forCellReuseIdentifier: "UsersTableViewCell")
    }
    
    func bind() {
        fetchUsersDone
            .subscribe { _ in
                self.usersTableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    func fetchUsersList() {
        print("UsersViewController - fetchUsersList")
        // Firestore 콜렉션 초기화
        let usersCollection = Firestore.firestore().collection("users").order(by: "creationTime", descending: true)
        // 콜렉션의 도큐먼트들을 가져와서 배열에 저장
        usersCollection.getDocuments { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            if let error = error {
                print("Error getting documents: \(error)")
                // 에러 처리: 사용자에게 메시지 표시 또는 기록
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents found.")
                return
            }
            self.users.removeAll()
            // 배열에 있는 각 도큐먼트에 접근
            print(documents.count)
            for document in documents {
                let user = UserModel(document: document)
                self.users.append(user)
            }
            fetchUsersDone.onNext(())
            print(users.count)
        }
    }

}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(users.count)
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.setData(userModel: users[indexPath.row])
        return cell
    }
    
}
