//
//  ViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/06.
//

import UIKit

class ChatListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var chatListTableView: UITableView!
    
    let dataStore = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.chatListTableView.delegate = self
        self.chatListTableView.dataSource = self
        let chatTableViewCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.chatListTableView.register(chatTableViewCell, forCellReuseIdentifier: "ChatTableViewCell")
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        guard let searchViewController = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as? SearchViewController else {
            print("ViewController-searchButtonClicked-error")
            return
        }
        searchViewController.modalPresentationStyle = .overFullScreen
        searchViewController.modalTransitionStyle = .crossDissolve
        self.present(searchViewController, animated: true)
    }
}

extension ChatListViewController:  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // chatListTableView에서 사용할 셀의 인스턴스 생성
        let cell = chatListTableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.profileImageView.image = UIImage(named: "\(indexPath.row + 1).png")
        cell.nameLabel.text = dataStore.chatList[indexPath.row].name
        cell.messagePreviewLabel.text = dataStore.chatList[indexPath.row].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // indexPath를 기반으로 해당 셀의 높이를 계산하고 반환
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ViewController-didSelectRowAt: \(indexPath.row)번 인덱스 눌림")
        let inChatViewController = self.storyboard?.instantiateViewController(identifier: "InChatViewController") as! InChatViewController
        inChatViewController.hidesBottomBarWhenPushed = true
        inChatViewController.paramChatPartnerName = dataStore.chatList[indexPath.row].name
        self.navigationController?.pushViewController(inChatViewController, animated: true)
    }

}
