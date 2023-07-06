//
//  SearchViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/07.
//
import Foundation
import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var searchBarTextField: UITextField!
    @IBOutlet var searchBarStackView: UIStackView!
    @IBOutlet var searchResultStackView: UIStackView!
    @IBOutlet var searchReseultTableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // 검색결과의 인덱스를 담음. appDelegate.chatList[searchResult[i]] 로 전체 배열에 접근
    lazy var searchResult: [Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.searchReseultTableView.delegate = self
        self.searchReseultTableView.dataSource = self
        self.searchBarTextField.delegate = self
        
        // nib 가져와서 테이블 뷰에 등록
        let searchResultTableViewCell = UINib(nibName: "SearchResultTableViewCell", bundle: nil)
        searchReseultTableView.register(searchResultTableViewCell, forCellReuseIdentifier: "SearchResultTableViewCell")
        
        uiInit()
        self.searchBarTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func uiInit(){
        searchBarStackView.layer.cornerRadius = 6
        searchResultStackView.layer.cornerRadius = 12
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.searchReseultTableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell", for: indexPath) as! SearchResultTableViewCell
        print("\(searchResult[indexPath.row]).png")
        
        cell.profileImageView.image = UIImage(named: "\(searchResult[indexPath.row]+1).png")
        cell.nameLabel.text = appDelegate.chatList[searchResult[indexPath.row]].name
        cell.messagePreviewLabel.text = appDelegate.chatList[searchResult[indexPath.row]].message
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SearchViewController: UITextFieldDelegate {
    // 리턴 될 때 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 검색한 결과 배열에 추가 후 배열 태이블뷰 업데이트
        let keyword = textField.text!
        let cl = appDelegate.chatList
        for i in 0..<cl.count {
            let name = cl[i].name!
            let message = cl[i].message!
            if name.contains(keyword) || message.contains(keyword) {
                searchResult.append(i)
            }
        }
        textField.resignFirstResponder()
        
        searchReseultTableView.reloadData()
        return true
    }
}
