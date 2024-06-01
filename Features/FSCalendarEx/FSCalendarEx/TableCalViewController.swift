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

class TableCalViewController: UIViewController {
    @IBOutlet var calTableView: UITableView!
    @IBOutlet var foldButtonStackView: UIStackView!
    
    let calendarMode = BehaviorRelay<CalendarMode>(value: .week)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        action()
    }
    
    // MARK: - initUI
    private func initUI() {
        // calTableView
        calTableView.delegate = self
        calTableView.dataSource = self
        // TableCalTableViewCell
        let tableCalTableViewCell = UINib(nibName: "TableCalTableViewCell", bundle: nil)
        calTableView.register(tableCalTableViewCell, forCellReuseIdentifier: "TableCalTableViewCell")
        // TodoTableViewCell
        let todoTableViewCell = UINib(nibName: "TodoTableViewCell", bundle: nil)
        calTableView.register(todoTableViewCell, forCellReuseIdentifier: "TodoTableViewCell")
    }
    
    // MARK: - action
    private func action() {
        foldButtonStackView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.setCalendarMode()
            })
            .disposed(by: disposeBag)
        
    }
    
    func setCalendarMode() {
        print(#function, calendarMode.value)
        let newMode: CalendarMode = self.calendarMode.value == .month ? .week : .month
        // TODO: - 화살표 방향 바꾸기
        print(newMode)
        calendarMode.accept(newMode)
    }

}

extension TableCalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let calCell = tableView.dequeueReusableCell(withIdentifier: "TableCalTableViewCell") as! TableCalTableViewCell
            calCell.tableCalVC = self
            calCell.bind()
            return calCell
        default:
            let todoCell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
            return todoCell
        }
    }
    
}
