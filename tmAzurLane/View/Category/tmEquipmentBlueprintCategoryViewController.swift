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
    
    lazy var presenter:tmEquipmentBlueprintPresenter? = {
        return tmEquipmentBlueprintPresenter(self)
    }()
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
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = presenter?.getNumberOfProfitMaterial(withTechNumber: 1) else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! tmEquipmentBlueprintCollectionViewCell
        cell.introduction.text = presenter?.getName(withRow: indexPath.row)
        guard let path = Bundle.main.path(forResource: presenter?.getPicture(withRow: indexPath.row), ofType: "png") else {
            return cell
        }
        
        let image = UIImage(contentsOfFile: path)
        cell.imageView.image = image
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

extension tmEquipmentBlueprintCategoryViewController:tmEquipmentBlueprintDelegate {
    
}

extension tmEquipmentBlueprintCategoryViewController {
    func initData() {
        presenter?.getFMResultSetFromProfitMaterial(withTechNumber: 1)
        collectionView.register(UINib.init(nibName: cellId, bundle:.main), forCellWithReuseIdentifier: cellId)
    }
}
