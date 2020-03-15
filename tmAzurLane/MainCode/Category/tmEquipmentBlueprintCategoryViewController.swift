//
//  tmEquipmentBlueprintCategoryViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/22.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

typealias blockData = (Int, String, String)
typealias chosen = (_ name:[blockData]?) -> Void

class tmEquipmentBlueprintCategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    /// 上一个点击的cell
    var tmTempViewCell:tmEquipmentBlueprintCollectionViewCell? = nil
    var clickIndex:Int?
    lazy var presenter:tmEquipmentBlueprintPresenter? = {
        return tmEquipmentBlueprintPresenter(self)
    }()
    let cellId = "tmEquipmentBlueprintCollectionViewCell"
    let bounds:CGFloat = 6
    var viewCellWidth:CGFloat = 0
    /// 每行显示的个数
    var rowNumber:Int = 3
    /// 根据techNumber选择显示内容
    lazy var techNumber:Int = {0}()
    var chosenElement:chosen? = nil
    
    convenience init(number:Int) {
        self.init()
        techNumber = number
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    
}

// MARK: - UICollectionViewDelegate
extension tmEquipmentBlueprintCategoryViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        clickIndex = indexPath.row
        let cellview = collectionView.cellForItem(at: indexPath) as! tmEquipmentBlueprintCollectionViewCell
        cellview.chosenImage.isHidden = !cellview.chosenImage.isHidden
        if tmTempViewCell == cellview {
            return
        }
        cellview.startAnimate(width: cellview.bounds.width)
        guard let tempViewCell = tmTempViewCell else {
            tmTempViewCell = cellview
            return
        }
        tempViewCell.pauseAnimate()
//        tempViewCell.chosenImage.isHidden = true
        tmTempViewCell = cellview
    }
    
}

// MARK: - UICollectionViewDataSource
extension tmEquipmentBlueprintCategoryViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = presenter?.getNumberOfProfitMaterial(withTechNumber: techNumber) else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! tmEquipmentBlueprintCollectionViewCell
        guard let text = presenter?.getName(withRow: indexPath.row) else {
            cell.introduction.text = ""
            return cell
        }
        cell.setIntroductionText(text, width: viewCellWidth)
        guard let picturePath = presenter?.getPicture(withRow: indexPath.row) else { return cell }
        let tempPath = kBundleDocumentPath()!+"/ShowPictures/"+picturePath
        let image = UIImage(contentsOfFile: tempPath)
        cell.imageView.image = image
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension tmEquipmentBlueprintCategoryViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let singleWidth = viewCellWidth
        return CGSize(width: singleWidth, height: singleWidth*5/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: bounds, left: bounds, bottom: bounds, right: bounds)
    }
    
}

// MARK: - tmEquipmentBlueprintDelegate
extension tmEquipmentBlueprintCategoryViewController:tmEquipmentBlueprintDelegate {
    
}

// MARK: - Private Method
extension tmEquipmentBlueprintCategoryViewController {
    
    func initData() {
        let addButton = UIBarButtonItem(title: "完成", style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonClick))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.hidesBackButton = true
        presenter?.getFMResultSetFromProfitMaterial(withTechNumber: techNumber)
        collectionView.register(UINib.init(nibName: cellId, bundle:.main), forCellWithReuseIdentifier: cellId)
        rowNumber = Int(UIScreen.main.bounds.size.width)/128
        viewCellWidth = (UIScreen.main.bounds.size.width-bounds*2*CGFloat(rowNumber))/CGFloat(rowNumber)
    }
    
    func getSelectedRow() -> [Int] {
        var result:[Int] = []
        for item in collectionView.visibleCells.enumerated() {
            let element = item.element as! tmEquipmentBlueprintCollectionViewCell
            if !element.chosenImage.isHidden {
                result.append(item.offset)
            }
        }
        return result
    }
    
    @objc func buttonClick() {
        let row = getSelectedRow()
        if row.count == 0 {
            alert()
            return
        }
        if chosenElement != nil {
            chosenElement!(presenter?.getBlockData(row))
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func alert() {
        let alert = UIAlertController(title: nil, message: "未选择，是否直接退出", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "确定", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        let action2 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        self.present(alert, animated: true, completion: nil)
    }
    
}
