//
//  TableCalViewController.swift
//  FSCalendarEx
//
//  Created by JDeoks on 6/2/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import FSCalendar

class TableCalViewController: UIViewController {
    @IBOutlet var calTableView: UITableView!
    @IBOutlet var foldButtonStackView: UIStackView!
    
    let calendarMode = BehaviorRelay<FSCalendarScope>(value: .week)
    let disposeBag = DisposeBag()
    
    // 캘린더의 높이를 저장하기 위한 변수
//    var calendarHeight: CGFloat = 400  // 초기 높이를 설정합니다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        action()
        calTableView.layoutIfNeeded()
    }
    
    private func initUI() {
        calTableView.delegate = self
        calTableView.dataSource = self
        
        let tableCalTableViewCell = UINib(nibName: "TableCalTableViewCell", bundle: nil)
        calTableView.register(tableCalTableViewCell, forCellReuseIdentifier: "TableCalTableViewCell")
        
        let todoTableViewCell = UINib(nibName: "TodoTableViewCell", bundle: nil)
        calTableView.register(todoTableViewCell, forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    private func action() {
        foldButtonStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.setCalendarMode()
            })
            .disposed(by: disposeBag)
    }
    
    func setCalendarMode() {
        let newMode: FSCalendarScope = calendarMode.value == .month ? .week : .month
        calendarMode.accept(newMode)
        
//        // 테이블 뷰의 레이아웃 업데이트
//        UIView.animate(withDuration: 0.3) {
//            self.calTableView.beginUpdates()
//            self.calTableView.endUpdates()
//        }
    }
    
}

extension TableCalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            print(type(of: self), #function)
            guard let calCell = tableView.dequeueReusableCell(withIdentifier: "TableCalTableViewCell") as? TableCalTableViewCell else {
                return UITableViewCell()
            }
            calCell.tableCalVC = self
            calCell.bind()
            return calCell
        default:
            guard let todoCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as? TodoTableViewCell else {
                return UITableViewCell()
            }
            todoCell.title.text = "\(indexPath)"
            return todoCell
        }
    }
    
    
}
