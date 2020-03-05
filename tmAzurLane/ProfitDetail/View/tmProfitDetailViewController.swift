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
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var ProgressBackView: UIView!
    @IBOutlet weak var progress: UIProgressView!
    
    private let cellId = "tmProfitDetailTableViewCell"
    private let addCellId = "tmAddProfitDetailedTableViewCell"
    private let add_string = "添加"
    private let edit_string = "编辑"
    private let save_string = "保存"
    
    var historyId:Int?
    lazy var presenter:tmProfitDetailPresenter? = {
        return tmProfitDetailPresenter(self)
    }()
    var addButton:UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initData()
    }
    
}

// MARK: - UITableViewDelegate
extension tmProfitDetailViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension tmProfitDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = presenter?.getCount(historyId) else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == tableView.numberOfRows(inSection: 0)-1 && presenter!.editingStatus {
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellId, for: indexPath) as! tmAddProfitDetailedTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! tmProfitDetailTableViewCell
            cell.introduction.text = presenter?.getName(withRow: indexPath.row)
            guard let number = presenter?.getNumber(withRow: indexPath.row) else { return cell }
            cell.number.text = String(number)
            cell.icon.image = presenter?.getIcon(withRow: indexPath.row)
            return cell
        }
    }
    
}

// MARK: - UIImagePicker
extension tmProfitDetailViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func buttonClick() {
        if presenter!.editingStatus {
            saveEditedData()
        } else if addButton?.title == edit_string {
            presenter?.startEdit()
        } else {
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
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //获取选择的原图
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = kTmpPath()+"tmp.png"
        let imageData = pickedImage.pngData()
        fileManager.createFile(atPath: rootPath, contents: imageData, attributes: nil)
        picker.dismiss(animated: true) {
            self.presenter?.add(kTmpPath()+"tmp.png")
        }
    }
    
}

// MARK: - tmProfitDetailedDelegate
extension tmProfitDetailViewController: tmProfitDetailedDelegate {
    func setProgress(_ value: Float) {
        progress.progress = value
    }
    
    func setProgressText(_ text: String) {
        progressLabel.text = text
    }
    
    func showProgress() {
        ProgressBackView.isHidden = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.hidesBackButton = true
    }
    
    func hideProgress() {
        ProgressBackView.isHidden = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.hidesBackButton = false
    }
    
}

// MARK: - Private Method
extension tmProfitDetailViewController {
    
    func initView() {
        addButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: self, action: #selector(buttonClick))
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    func initData() {
        reloadData()
        tableview.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
        tableview.register(UINib.init(nibName: addCellId, bundle:.main), forCellReuseIdentifier: addCellId)
    }
    
    func reloadData() {
        presenter?.getData(historyId)
        if getNumber() {
            addButton?.title = edit_string
        } else {
            addButton?.title = add_string
        }

    }
    
    /// 查询结果是否大于0
    func getNumber() -> Bool {
        guard let number = presenter?.getCount(historyId) else {
            return false
        }
        if number <= 0 {
            return false
        }
        return true
    }
    
    func saveEditedData() {
        let numberOfRows = tableview.numberOfRows(inSection: 0)
        if numberOfRows <= 0 {
            return
        }
        for i in 1...numberOfRows {
            
        }
        
        
        
        
        
        presenter?.editingStatus = false
        
    }
    
}
