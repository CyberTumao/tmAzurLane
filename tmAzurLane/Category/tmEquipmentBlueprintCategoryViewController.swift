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
    
    var tmTempViewCell:tmEquipmentBlueprintCollectionViewCell? = nil
    
    lazy var presenter:tmEquipmentBlueprintPresenter? = {
        return tmEquipmentBlueprintPresenter(self)
    }()
    let cellId = "tmEquipmentBlueprintCollectionViewCell"
    let viewCellWidth = (UIScreen.main.bounds.size.width-30)/3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
}

extension tmEquipmentBlueprintCategoryViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellview = collectionView.cellForItem(at: indexPath) as! tmEquipmentBlueprintCollectionViewCell
        if tmTempViewCell == cellview {
            print("tmTempViewCell==cellview")
            return
        }
        cellview.startAnimate(width: cellview.bounds.width)
        guard let tempViewCell = tmTempViewCell else {
            tmTempViewCell = cellview
            print("tmTempViewCell==nil")
            return
        }
//        print("\(tempViewCell)")
//        print("\(cellview)")
        print("tempViewCell.pause")
        tempViewCell.pauseAnimate()
        tmTempViewCell = cellview
    }
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
        guard let text = presenter?.getName(withRow: indexPath.row) else {
            cell.introduction.text = ""
            return cell
        }
        cell.setIntroductionText(text, width: viewCellWidth)
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
        let singleWidth = viewCellWidth
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
