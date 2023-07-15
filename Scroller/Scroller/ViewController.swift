//
//  ViewController.swift
//  Scroller
//
//  Created by 서정덕 on 2023/07/14.
//

import UIKit

class ViewController: UIViewController {

    private var selection: Int = 0
    private var valueH: CGFloat = 0
    private var valueV: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let tabView = UITabBarController()
        
        let verticalViewController = UIViewController()
        verticalViewController.view.backgroundColor = .white
        verticalViewController.tabBarItem = UITabBarItem(title: "Vertical", image: UIImage(systemName: "square.split.1x2"), tag: 0)
        let verticalLabel = UILabel()
        verticalLabel.text = "● Vertical Total Value: \(valueV)"
        verticalLabel.font = UIFont.boldSystemFont(ofSize: 14)
        verticalLabel.textColor = .orange
        let verticalScroller = UIScrollView()
        let verticalContentStackView = UIStackView()
        verticalContentStackView.axis = .vertical
        verticalContentStackView.spacing = 8
        verticalScroller.addSubview(verticalContentStackView)
        verticalScroller.translatesAutoresizingMaskIntoConstraints = false
        verticalContentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalScroller.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            verticalScroller.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            verticalScroller.topAnchor.constraint(equalTo: view.topAnchor),
            verticalScroller.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            verticalContentStackView.leadingAnchor.constraint(equalTo: verticalScroller.leadingAnchor),
            verticalContentStackView.trailingAnchor.constraint(equalTo: verticalScroller.trailingAnchor),
            verticalContentStackView.topAnchor.constraint(equalTo: verticalScroller.topAnchor),
            verticalContentStackView.bottomAnchor.constraint(equalTo: verticalScroller.bottomAnchor),
            verticalContentStackView.widthAnchor.constraint(equalTo: verticalScroller.widthAnchor)
        ])
        verticalContentStackView.addArrangedSubview(verticalLabel)
        for index in 0...5 {
            let contentLabel = UILabel()
            contentLabel.text = "Vertical Content \(index)"
            verticalContentStackView.addArrangedSubview(contentLabel)
        }
        
        let horizontalViewController = UIViewController()
        horizontalViewController.view.backgroundColor = .white
        horizontalViewController.tabBarItem = UITabBarItem(title: "Horizontal", image: UIImage(systemName: "square.split.2x1"), tag: 1)
        let horizontalLabel = UILabel()
        horizontalLabel.text = "● Horizontal Total Value: \(valueH)"
        horizontalLabel.font = UIFont.boldSystemFont(ofSize: 14)
        horizontalLabel.textColor = .purple
        let horizontalScroller = UIScrollView()
        let horizontalContentStackView = UIStackView()
        horizontalContentStackView.axis = .horizontal
        horizontalContentStackView.spacing = 8
        horizontalScroller.addSubview(horizontalContentStackView)
        horizontalScroller.translatesAutoresizingMaskIntoConstraints = false
        horizontalContentStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalScroller.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            horizontalScroller.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            horizontalScroller.topAnchor.constraint(equalTo: view.topAnchor),
            horizontalScroller.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            horizontalContentStackView.leadingAnchor.constraint(equalTo: horizontalScroller.leadingAnchor),
            horizontalContentStackView.trailingAnchor.constraint(equalTo: horizontalScroller.trailingAnchor),
            horizontalContentStackView.topAnchor.constraint(equalTo: horizontalScroller.topAnchor),
            horizontalContentStackView.bottomAnchor.constraint(equalTo: horizontalScroller.bottomAnchor),
            horizontalContentStackView.heightAnchor.constraint(equalTo: horizontalScroller.heightAnchor)
        ])
        horizontalContentStackView.addArrangedSubview(horizontalLabel)
        for index in 0...5 {
            let contentLabel = UILabel()
            contentLabel.text = "Horizontal Content \(index)"
            horizontalContentStackView.addArrangedSubview(contentLabel)
        }
        
        tabView.viewControllers = [verticalViewController, horizontalViewController]
        
        self.addChild(tabView)
        self.view.addSubview(tabView.view)
        tabView.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tabView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tabView.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            tabView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        tabView.didMove(toParent: self)
    }
}
