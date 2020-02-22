//
//  tmEquipmentBlueprintCategoryViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmEquipmentBlueprintCategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellId = "tmEquipmentBlueprintCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
}

extension tmEquipmentBlueprintCategoryViewController:UICollectionViewDelegate {
    
}

extension tmEquipmentBlueprintCategoryViewController:UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
}

extension tmEquipmentBlueprintCategoryViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        let singleWidth = (width-30)/3
        return CGSize(width: singleWidth, height: singleWidth*5/4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}

extension tmEquipmentBlueprintCategoryViewController {
    func initData() {
        collectionView.register(UINib.init(nibName: cellId, bundle:.main), forCellWithReuseIdentifier: cellId)
    }
}
