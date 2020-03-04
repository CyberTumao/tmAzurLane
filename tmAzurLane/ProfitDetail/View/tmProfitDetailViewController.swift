//
//  tmProfitDetailViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmProfitDetailViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
   
    let cellId = "tmProfitDetailTableViewCell"
    var historyId:Int?
    lazy var presenter:tmProfitDetailPresenter? = {
        return tmProfitDetailPresenter()
    }()
    var addButton:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    func initData() {
        presenter?.getData(historyId)
        tableview.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
        addButton = UIBarButtonItem(title: "添加", style: UIBarButtonItem.Style.plain, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addButton
    }
}

extension tmProfitDetailViewController: UITableViewDelegate {
    
}

extension tmProfitDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = presenter?.getCount(historyId) else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! tmProfitDetailTableViewCell
        cell.introduction.text = presenter?.getName(withRow: indexPath.row)
        guard let number = presenter?.getNumber(withRow: indexPath.row) else { return cell }
        cell.number.text = String(number)
        cell.icon.image = presenter?.getIcon(withRow: indexPath.row)
        return cell
    }
    
}

extension tmProfitDetailViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @objc func add() {
        let fileArray = FileManager.default.subpaths(atPath: kTmpPath())
        for fn in fileArray!{
            try! FileManager.default.removeItem(atPath: kTmpPath() + "\(fn)")
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            //初始化图片控制器
            let picker = UIImagePickerController()
            //设置代理
            picker.delegate = self
            //指定图片控制器类型
            picker.sourceType = .photoLibrary
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: {
                () -> Void in
                
            })
        }else{
            print("读取相册错误")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //获取选择的原图
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = kTmpPath()+"tmp.png"
        let imageData = pickedImage.pngData()
        fileManager.createFile(atPath: rootPath, contents: imageData, attributes: nil)
        self.dismiss(animated: true, completion: nil)
        presenter?.add(kTmpPath()+"tmp.png")
    }
}
