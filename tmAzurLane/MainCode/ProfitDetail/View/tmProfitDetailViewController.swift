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
    private let action_add_method_1 = "扫描截图"
    private let action_add_method_2 = "直接添加"
    private let action_design_diagram_1 = "科研一期设计图"
    private let action_design_diagram_2 = "科研二期设计图"
    private let action_blueprint1 = "科研一期蓝图"
    private let action_blueprint2 = "科研二期蓝图"
    private let action_other = "其它"
    
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0)-1 && presenter!.editingStatus {
            showAlert(indexPath)
        }
    }
}

// MARK: - UITableViewDataSource
extension tmProfitDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
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
            if !presenter!.editingStatus {
                cell.plus.isHidden = true
                cell.minus.isHidden = true
            } else {
                cell.plus.isHidden = false
                cell.minus.isHidden = false
            }
            guard let number = presenter?.getNumber(withRow: indexPath.row) else { return cell }
            cell.number.text = String(number)
            cell.setCount(number)
            cell.countChange = { (count) in
                self.presenter!.changeNumber(count, indexPath.row)
            }
            if presenter!.isBluePrint(withRow: indexPath.row) {
                cell.bpIcon.isHidden = false
                cell.icon.isHidden = true
                cell.bpIcon.image = presenter?.getIcon(withRow: indexPath.row)
            } else {
                cell.bpIcon.isHidden = true
                cell.icon.isHidden = false
                cell.icon.image = presenter?.getIcon(withRow: indexPath.row)
            }
            return cell
        }
    }
    
}

// MARK: - UIImagePicker
extension tmProfitDetailViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    /// 打开相册
    func openPhotoLibrary() {
        let fileArray = FileManager.default.subpaths(atPath: kTmpPath())
        for fn in fileArray! {
          if fn != "com.apple.dyld" {
              try! FileManager.default.removeItem(atPath: kTmpPath() + "\(fn)")
          }
        //  3.21
        //  真机运行时删除 com.apple.dyld 会崩溃
        //  try! FileManager.default.removeItem(atPath: kTmpPath() + "\(fn)")
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
          //初始化图片控制器
          let picker = UIImagePickerController()
          //设置代理
          picker.delegate = self
          //指定图片控制器类型
          picker.sourceType = .photoLibrary
          //弹出控制器，显示界面
          self.present(picker, animated: true) {

          }
        }else{
          print("读取相册错误")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //获取选择的原图
        let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //将选择的图片保存到tmp目录下
        let fileManager = FileManager.default
        let rootPath = kTmpPath()+"tmp.png"
        let imageData = pickedImage.pngData()
        fileManager.createFile(atPath: rootPath, contents: imageData, attributes: nil)
        picker.dismiss(animated: true) {
            self.presenter?.startEdit()
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
        reloadData()
        tableview.reloadData()
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
        buttonChange()

    }
    
    /// ui逻辑修改，右上角按钮常态为编辑，读取图片的添加移到下方
    /// 仍然是只有为空时才可以使用图片添加功能
    ///  旧代码
    /// ```
    /// if getNumber() {
    ///     if presenter!.editingStatus {
    ///         addButton?.title = save_string
    ///     } else {
    ///         addButton?.title = edit_string
    ///     }
    /// } else {
    ///     addButton?.title = add_string
    /// }
    /// ```
    func buttonChange() {
        if presenter!.editingStatus {
            addButton?.title = save_string
        } else {
            addButton?.title = edit_string
        }
    }
    
    /// 查询结果是否大于0
    func getNumber() -> Bool {
        guard let number = presenter?.getCount(historyId) else {
            return false
        }
        return number <= 0 ? false : true
        
    }
    
    /// 根据当前的状态选择处理方式
    ///
    @objc func buttonClick() {
        if presenter!.editingStatus {
            saveEditedData()
        } else if getNumber() {
            presenter?.startEdit()
            buttonChange()
            tableview.reloadData()
        } else {
            showAddWays()
        }
        
    }
    
    func saveEditedData() {
        var profitNumbers:[Int] = []
        let numberOfRows = tableview.numberOfRows(inSection: 0)
        if numberOfRows < 1 {
            return
        } else if numberOfRows > 1 {
            for i in 1...numberOfRows-1 {
                profitNumbers.append(Int((tableview.cellForRow(at: IndexPath(row: i-1, section: 0)) as! tmProfitDetailTableViewCell).number!.text!)!)
            }
        }
        
        presenter?.saveData(historyId, profitNumbers)
        
        presenter?.editingStatus = false
        reloadData()
        tableview.reloadData()
    }
    
    /// 点击右上角后弹出的选单
    func showAddWays() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action_add_method_1, style: .default) { (action) in
            self.openPhotoLibrary()
        }
        let action2 = UIAlertAction(title: action_add_method_2, style: .default) { (action) in
            self.presenter?.startEdit()
            self.buttonChange()
            self.tableview.reloadData()
            self.showAlert(withFrame: CGRect(x: self.navigationController!.navigationBar.frame.width-50, y: 0, width: 10, height: 10))
        }
        let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let popover = alert.popoverPresentationController
            popover?.sourceView = self.tableview
            popover?.sourceRect = CGRect(x: self.navigationController!.navigationBar.frame.width-50, y: 0, width: 10, height: 10)
            popover?.permittedArrowDirections = .any
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ indexPath: IndexPath) -> Void {
        showAlert(withFrame:tableview.cellForRow(at: indexPath)!.frame)
    }
    
    func showAlert(withFrame frame:CGRect) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: action_design_diagram_1, style: .default) { (action) in
            self.pushToView(1)
        }
        let action2 = UIAlertAction(title: action_design_diagram_2, style: .default) { (action) in
            self.pushToView(2)
        }
        let action3 = UIAlertAction(title: action_blueprint1, style: .default) { (action) in
            self.pushToView(3)
        }
        let action4 = UIAlertAction(title: action_blueprint2, style: .default) { (action) in
            self.pushToView(4)
        }
        let action5 = UIAlertAction(title: action_other, style: .default) { (action) in
            self.pushToView(5)
        }
        let action6 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        alert.addAction(action5)
        alert.addAction(action6)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let popover = alert.popoverPresentationController
            popover?.sourceView = self.tableview
            popover?.sourceRect = frame
            popover?.permittedArrowDirections = .any
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func pushToView(_ number:Int) -> Void {
        let viewController = tmEquipmentBlueprintCategoryViewController(number: number)
        viewController.chosenElement = {(data) in
            guard let data = data else { return }
            for item in data {
                self.presenter?.addData(id: item.0, name: item.2, picture: item.1)
            }
            self.tableview.reloadData()
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
