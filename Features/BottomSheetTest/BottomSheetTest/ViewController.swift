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
        
    }

    override func viewDidAppear(_ animated: Bool) {
        SceneManager.shared.presentBottomSheet(vc: self)
    }
    
    func floatingPanelDidMove(_ fpc: FloatingPanelController) {
        print(fpc.state)
    }
    
}

class MyFloatingPanelLayout: FloatingPanelLayout {

    var position: FloatingPanelPosition {
        return .bottom
    }

    var initialState: FloatingPanelState {
        return .half
    }

    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] { // 가능한 floating panel: 현재 full, half만 가능하게 설정
        return [
//            .full: FloatingPanelLayoutAnchor(absoluteInset: 16.0, edge: .top, referenceGuide: .safeArea),
            .half: FloatingPanelLayoutAnchor(absoluteInset: 200, edge: .bottom, referenceGuide: .safeArea),
        ]
    }
}


class SceneManager {
    static let shared = SceneManager()
    private init() { }
    func presentBottomSheet(vc: UIViewController & FloatingPanelControllerDelegate) {
        let fpc = MyFloatingPanelController(delegate: vc)
        let contentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentViewController") as! ContentViewController
        fpc.surfaceView.backgroundColor = contentVC.view.backgroundColor
        fpc.set(contentViewController: contentVC)
//        controller.track(scrollView: contentVC.tableView)
        fpc.isRemovalInteractionEnabled = true
        fpc.layout = MyFloatingPanelLayout()
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.addPanel(toParent: vc)
    }
}

class MyFloatingPanelController: FloatingPanelController {
    deinit {
        print("\(type(of: self)) - \(#function)")
    }
}
