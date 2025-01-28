//
//  HomeViewController.swift
//  InstructionsTest
//
//  Created by JDeoks on 12/19/24.
//

import UIKit
import Instructions
import Then
import SnapKit

class HomeViewController: UIViewController, CoachMarksControllerDataSource, CoachMarksControllerDelegate {
    
    private let coachMarksController = CoachMarksController()

    let redView = UIView().then {
        $0.backgroundColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(redView)
        redView.snp.makeConstraints {
            $0.size.equalTo(100)
            $0.center.equalToSuperview()
        }
        
        // CoachMarksController 초기 설정
        coachMarksController.dataSource = self
        coachMarksController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        coachMarksController.start(in: .window(over: self))
    }
    
    // MARK: - CoachMarksControllerDataSource
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        // 코치마크 단계 수를 반환 (여기서는 redView 하나를 강조하므로 1)
        return 1
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkAt index: Int) -> CoachMark {
        // 강조할 뷰를 기준으로 CoachMark 생성
        return coachMarksController.helper.makeCoachMark(for: redView)
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController,
                              coachMarkViewsAt index: Int,
                              madeFrom coachMark: CoachMark
    ) -> (bodyView: (any UIView & CoachMarkBodyView), arrowView: (any UIView & CoachMarkArrowView)?) {
        
        // 기본 CoachMark 뷰 생성
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true,
                                                                           arrowOrientation: coachMark.arrowOrientation)
        // 힌트 텍스트 지정
        coachViews.bodyView.hintLabel.text = "이 영역은 중요하니 주목하세요!"
        coachViews.bodyView.nextLabel.text = "확인"
        
        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }
}
