//
//  ViewController.swift
//  BottomSheetTest
//
//  Created by JDeoks on 7/12/24.
//

import UIKit
import FloatingPanel

class ViewController: UIViewController, FloatingPanelControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        SceneManager.shared.presentBottomSheet(vc: self, animated: false)
        let url = URL(string: "nil")
        print(url!)
    }
    
    // 스와이프 추적
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        print(fpc.state)
    }
    
    @IBAction func showBottomSheetTapped(_ sender: Any) {
        SceneManager.shared.presentBottomSheet(vc: self, animated: true)
    }
}

class SceneManager {
    static let shared = SceneManager()
    private init() { }
    func presentBottomSheet(vc: UIViewController & FloatingPanelControllerDelegate, animated: Bool) {
        
        let contentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        
        // fpc가 표시할 뷰컨트롤러 설정
        let fpc = MyFloatingPanelController(delegate: vc)
        fpc.set(contentViewController: contentVC)
        
        // backdropView
        // 딤뷰 색 설정.알파값은 FloatingPanelLayout에서
        fpc.backdropView.backgroundColor = .black
        // 딤뷰 탭하면 바텀싯 닫기
        fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = true
        
        // SurfaceAppearance
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 20
        // 주어진 뷰 크기 벗어나게 스크롤 시 배경색 같도록 설정
        appearance.backgroundColor = contentVC.view.backgroundColor
        fpc.surfaceView.appearance = appearance

        // 스크롤뷰 최대 스크롤 추적해서 닫히기 설정
        // controller.track(scrollView: contentVC.tableView)
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = MyFloatingPanelLayout()
        // 바텀싯 손잡이 보이기 설정
        fpc.surfaceView.grabberHandle.isHidden = true
        
        // fpc present
        // addPanel, present 두 방법 모두 가능
//        fpc.addPanel(toParent: vc, animated: animated)
        vc.present(fpc, animated: true)
    }
}

class MyFloatingPanelLayout: FloatingPanelLayout {
    var heightFromSuperView: CGFloat = 292

    init(height: CGFloat = 292) {
        self.heightFromSuperView = height
    }
    // 바텀싯이 올라오는 위치 결정
    var position: FloatingPanelPosition {
        return .bottom
    }
    
    // 초기 상태 설정
    var initialState: FloatingPanelState {
        return .half
    }

    // 가능한 모드 배열 설정
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
//            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: heightFromSuperView, edge: .bottom, referenceGuide: .superview),
        ]
    }
    
    // 딤뷰 알파값 결정
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        switch state {
        case .full, .half: return 0.5
        default: return 0.0
        }
    }
    
}

class MyFloatingPanelController: FloatingPanelController {
    deinit {
        print("\(type(of: self)) - \(#function)")
    }
}
