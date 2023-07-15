//
//  MoreViewController.swift
//  HW7.4
//
//  Created by 서정덕 on 2023/07/15.
//

import UIKit

class MoreViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet var moreCollectionView: UICollectionView!
    
    fileprivate let systemImageNameArray = [
        "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "moon", "zzz", "sparkles", "cloud", "tornado", "smoke.fill", "tv.fill", "gamecontroller", "headphones", "flame", "bolt.fill", "hare", "tortoise", "ant", "hare", "car", "airplane", "heart", "bandage", "waveform.path.ecg", "staroflife", "bed.double.fill", "signature", "bag", "cart"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moreCollectionCell = UINib(nibName: "MoreCollectionViewCell", bundle: nil)
        self.moreCollectionView.register(moreCollectionCell, forCellWithReuseIdentifier: "MoreCollectionViewCell")
        
        moreCollectionView.delegate = self
        moreCollectionView.dataSource = self
        self.moreCollectionView.collectionViewLayout = createCompositionalLayoutForFirst()
        moreCollectionView.isScrollEnabled = false
        // Do any additional setup after loading the view.
    }
    

    func createCompositionalLayoutForFirst() -> UICollectionViewLayout {
        
    }

}

extension MoreViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return systemImageNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moreCollectionView.dequeueReusableCell(withReuseIdentifier: "MoreCollectionViewCell", for: indexPath) as! MoreCollectionViewCell
        cell.cellImageView.image = UIImage(systemName: systemImageNameArray[indexPath.row])
        cell.cellLabel.text = systemImageNameArray[indexPath.row]
        return cell
    }
    
}
