//
//  ViewController.swift
//  CollectionView
//
//  Created by 서정덕 on 2023/07/15.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate{

    
    @IBOutlet var myCollectionView: UICollectionView!
    
    fileprivate let systemImageNameArray = [
        "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "ant", "hare", "car", "airplane", "heart", "bandage", "waveform.path.ecg", "staroflife", "bed.double.fill", "signature", "bag", "cart"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myCollectionViewCell = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        myCollectionView.register(myCollectionViewCell, forCellWithReuseIdentifier: "MyCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        // 콜렉션 뷰에 대한 설정

        // 콜렉션 뷰의 autoresizingMask 속성을 설정합니다.
        // .flexibleWidth 옵션은 콜렉션 뷰의 너비가 부모 뷰의 너비 조정에 따라 자동으로 조정되도록 설정합니다.
        // .flexibleHeight 옵션은 콜렉션 뷰의 높이가 부모 뷰의 높이 조정에 따라 자동으로 조정되도록 설정합니다.
        myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // 콜렉션 뷰의 데이터 소스를 설정합니다.
        // self는 현재 ViewController가 UICollectionViewDataSource 프로토콜을 준수하고 있음을 나타냅니다.
        // 데이터 소스는 콜렉션 뷰의 데이터를 제공하고, 필요한 셀을 생성하고 구성하는 역할을 합니다.
        myCollectionView.dataSource = self

        // 콜렉션 뷰의 델리게이트를 설정합니다.
        // self는 현재 ViewController가 UICollectionViewDelegate 프로토콜을 준수하고 있음을 나타냅니다.
        // 델리게이트는 콜렉션 뷰의 동작을 처리하고 사용자 상호작용에 응답하는 역할을 합니다.
        myCollectionView.delegate = self

        self.myCollectionView.collectionViewLayout = createCompositionalLayoutForFirst()
        myCollectionView.isScrollEnabled = false
    }
    
    // 콤포지셔널 레이아웃 설정

    // 콤포지셔널 레이아웃을 생성하는 함수입니다.
    fileprivate func createCompositionalLayoutForFirst() -> UICollectionViewLayout {
        print("createCompositionalLayoutForFirst() called")
        
        // 콤포지셔널 레이아웃을 생성합니다.
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            // 아이템에 대한 사이즈를 정의합니다.
            // widthDimension은 아이템의 너비를 나타내며, .fractionalWidth(1.0)은 콜렉션 뷰의 너비의 전체(100%)로 설정합니다.
            // heightDimension은 아이템의 높이를 나타내며, .fractionalHeight(1.0)은 콜렉션 뷰의 높이의 전체(100%)로 설정합니다.
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            
            // 위에서 정의한 아이템 사이즈로 아이템을 생성합니다.
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 아이템 간의 간격을 설정합니다.
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 3, bottom: 2, trailing: 3)
            
            // 그룹의 높이를 설정합니다.
            // NSCollectionLayoutDimension.fractionalWidth(1/3)은 콜렉션 뷰 너비의 1/3을 나타냅니다.
            let groupHeight = NSCollectionLayoutDimension.fractionalWidth(1/5)
            
            // 그룹의 사이즈를 정의합니다.
            // widthDimension은 그룹의 너비를 나타내며, .fractionalWidth(1.0)은 콜렉션 뷰의 너비의 전체(100%)로 설정합니다.
            // heightDimension은 위에서 정의한 그룹의 높이로 설정합니다.
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: groupHeight)
            
            // 그룹 사이즈로 그룹을 생성합니다.
            // horizontal 방향으로 그룹을 생성하며, 그룹 내에 1개의 아이템이 배치됩니다.
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
            
            // 그룹으로 섹션을 생성합니다.
            let section = NSCollectionLayoutSection(group: group)
            
            // 섹션에 대한 간격을 설정합니다.
            section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
            
            return section
        }
        
        return layout
    }



}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImageNameArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MyCollectionViewCell.self), for: indexPath) as! MyCollectionViewCell
        cell.myLabel.text = self.systemImageNameArray[indexPath.item]
        cell.myImageView.image = UIImage(systemName: self.systemImageNameArray[indexPath.item])
        return cell
    }
}
