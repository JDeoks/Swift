//
//  FriendsListViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/14.
//

import UIKit

class FriendsListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var friendsListTableView: UITableView!
    
    let dataStore = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsListTableView.delegate = self
        friendsListTableView.dataSource = self
        let friendsListTableViewCell = UINib(nibName: "FriendsListTableViewCell", bundle: nil)
        self.friendsListTableView.register(friendsListTableViewCell, forCellReuseIdentifier: "FriendsListTableViewCell")
        // Do any additional setup after loading the view.
    }

}

extension FriendsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataStore.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendsListTableView.dequeueReusableCell(withIdentifier: "FriendsListTableViewCell", for: indexPath) as! FriendsListTableViewCell
        cell.profileImageView.image = UIImage(named: "\(indexPath.row + 1).png")
        cell.nameLabel.text = dataStore.chatList[indexPath.row].name
        cell.profileMessageLabel.text = dataStore.chatList[indexPath.row].message
        return cell
    }

}
