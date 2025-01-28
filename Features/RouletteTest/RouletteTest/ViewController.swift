//
//  ViewController.swift
//  RouletteTest
//
//  Created by JDeoks on 1/17/25.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    var sceneView: SCNView!
    var rouletteNode: SCNNode!
    var lastPanAngle: CGFloat = 0.0 // 드래그 시작 시 각도

    override func viewDidLoad() {
        super.viewDidLoad()

        // SceneView 초기화
        sceneView = SCNView(frame: view.bounds)
        sceneView.scene = SCNScene()
        sceneView.allowsCameraControl = false // 사용자가 드래그로 제어
        sceneView.backgroundColor = .black
        view.addSubview(sceneView)

        // 룰렛 노드 추가
        setupRoulette()

        // 제스처 추가
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sceneView.addGestureRecognizer(panGesture)
    }

  func setupRoulette() {
      // 룰렛 베이스
      let baseGeometry = SCNCylinder(radius: 5, height: 0.2)
      baseGeometry.firstMaterial?.diffuse.contents = UIColor.red
      rouletteNode = SCNNode(geometry: baseGeometry)
      rouletteNode.position = SCNVector3(0, 0, 0)

      // 슬롯 추가
      let slotCount = 12
      for i in 0..<slotCount {
          let slot = SCNNode(geometry: SCNBox(width: 0.2, height: 0.5, length: 0.1, chamferRadius: 0))
          slot.geometry?.firstMaterial?.diffuse.contents = (i % 2 == 0) ? UIColor.white : UIColor.black
          let angle = Float(i) * (2 * Float.pi / Float(slotCount))
          slot.position = SCNVector3(5 * cos(angle), 0.25, 5 * sin(angle))
          slot.eulerAngles.y = -angle
          rouletteNode.addChildNode(slot)
      }

      // 물리적 설정 추가
      rouletteNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
      rouletteNode.physicsBody?.isAffectedByGravity = false // 중력 비활성화
      rouletteNode.physicsBody?.angularDamping = 0.5 // 회전 감속
      rouletteNode.physicsBody?.mass = 5.0
      rouletteNode.physicsBody?.angularVelocityFactor = SCNVector3(0, 1, 0) // Z축으로만 회전

      // Scene에 룰렛 추가
      sceneView.scene?.rootNode.addChildNode(rouletteNode)

      // 카메라 추가
      addCamera()
  }

  func addCamera() {
      // 카메라 노드 생성
      let cameraNode = SCNNode()
      cameraNode.camera = SCNCamera()

      // 카메라 위치 설정 (룰렛 위쪽 대각선 시야)
      cameraNode.position = SCNVector3(0, 8, 10)

      // 카메라가 룰렛을 바라보도록 설정
      cameraNode.look(at: SCNVector3(0, 0, 0))

      // Scene에 카메라 추가
      sceneView.scene?.rootNode.addChildNode(cameraNode)
  }



    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: sceneView)
        let rotationForce = CGFloat(velocity.x) / 50

        switch gesture.state {
        case .began:
            lastPanAngle = 0.0
        case .changed:
            // 제스처로 룰렛 회전
            let currentAngle = lastPanAngle + rotationForce
            rouletteNode.physicsBody?.applyTorque(SCNVector4(0, 1, 0, Float(currentAngle)), asImpulse: true)
        case .ended:
            // 회전 종료 후 걸리는 느낌 적용
            snapToNearestSlot()
        default:
            break
        }
    }

    func snapToNearestSlot() {
        // 슬롯 수와 현재 각도를 기반으로 걸리는 위치 계산
        let slotCount = 12
        let currentRotation = rouletteNode.eulerAngles.y
        let slotAngle = (2 * .pi) / Float(slotCount)
        let nearestSlot = round(currentRotation / slotAngle) * slotAngle

        // 룰렛이 부드럽게 멈추도록 애니메이션
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        rouletteNode.eulerAngles.y = nearestSlot
        SCNTransaction.commit()
    }
}

