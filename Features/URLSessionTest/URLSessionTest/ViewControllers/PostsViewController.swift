//
//  ViewController.swift
//  URLSessionTest
//
//  Created by JDeoks on 3/14/24.
//

import UIKit
import RxSwift
import RxCocoa

class PostsViewController: UIViewController {
    
    private let postsViewModel = PostsViewModel()

    let disposeBag = DisposeBag()
    
    private let refreshControl = UIRefreshControl()
    
    @IBOutlet var postsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initData()
        action()
        bind()
    }
    
    private func initUI() {
        // postsTableView
        postsTableView.dataSource = self
        postsTableView.delegate = self
        let postTableViewCell = UINib(nibName: "PostsTableViewCell", bundle: nil)
        postsTableView.register(postTableViewCell, forCellReuseIdentifier: "PostsTableViewCell")
        postsTableView.refreshControl = refreshControl
    }
    
    private func initData() {
        postsViewModel.fetchPosts()
    }
    
    private func action() {
        refreshControl.rx.controlEvent(.valueChanged)
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.postsViewModel.fetchPosts()
                self?.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)
    }
    
    private func bind() {
        postsViewModel.fetchPostsDone
            .subscribe { result in
                switch result {
                case true:
                    DispatchQueue.main.async {
                        self.postsTableView.reloadData()
                    }
                case false:
                    print("fetchBoardsDone Failed")
                }
            }.disposed(by: disposeBag)
    }

}

// MARK: - TableView
extension PostsViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "PostsTableViewCell", for: indexPath) as! PostsTableViewCell
        cell.setData(post: postsViewModel.posts[indexPath.row])
        return cell
    }
    
}
