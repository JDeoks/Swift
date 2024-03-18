//
//  UsersViewController.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {
    
    private let usersViewModel = UsersViewModel()
    
    let disposeBag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()

    @IBOutlet var usersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initData()
        action()
        bind()
    }
    
    private func initUI() {
        // postsTableView
        usersTableView.dataSource = self
        usersTableView.delegate = self
        let usersTableViewCell = UINib(nibName: "UsersTableViewCell", bundle: nil)
        usersTableView.register(usersTableViewCell, forCellReuseIdentifier: "UsersTableViewCell")
        usersTableView.refreshControl = refreshControl
    }
    
    private func initData() {
        usersViewModel.fetchUsers()
    }
    
    private func action() {
        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.usersViewModel.fetchUsers()
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        usersViewModel.fetchUsersDone
            .subscribe { result in
                switch result {
                case true:
                    DispatchQueue.main.async {
                        self.usersTableView.reloadData()
                    }
                case false:
                    print("fetchUsersDone Failed")
                }
            }.disposed(by: disposeBag)
    }

}

// MARK: - TableView
extension UsersViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as! UsersTableViewCell
        cell.setData(user: usersViewModel.users[indexPath.row])
        return cell
    }
    
}
