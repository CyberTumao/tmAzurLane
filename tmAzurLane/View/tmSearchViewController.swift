//
//  tmSearchViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/18.
//  Copyright © 2020 tumao. All rights reserved.
//

import SwiftUI
import UIKit

class tmSearchViewController: UIViewController {
    
    let cellId = "tmSearchTableViewCell"
    lazy var shArray: [Bool] = {
        let temp = [true, true]
        return temp
    }()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData()
    }
    
}

extension tmSearchViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.popToViewController(tmEquipmentBlueprintCategoryViewController(), animated:true)
    }
}

extension tmSearchViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = tmDataBaseManager.shareInstance.selectFromTech(withNumber: section+1)
        let headView = tmHeadView()
        headView.tag = section
        headView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOrHide(tap:))))
        headView.isUserInteractionEnabled = true
        headView.label.text = text
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shArray[section] ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
    }
}

extension tmSearchViewController:UIGestureRecognizerDelegate {
    @objc fileprivate func showOrHide(tap sender:UITapGestureRecognizer) -> Void {
        guard sender.view!.tag >= 0 && sender.view!.tag<shArray.count else {
            return
        }
        let temp = shArray[sender.view!.tag]
        shArray[sender.view!.tag] = !temp
        tableView.reloadSections(IndexSet(integer: sender.view!.tag), with: UITableView.RowAnimation.fade)
    }
}

extension tmSearchViewController {
    func initData() -> Void {
        tableView.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
    }
}

// MARK: - swiftUI
struct UIBVCPresenter: UIViewControllerRepresentable {
    ///UIViewControllerRepresentable  协议中必须实现的方法 -  当 SwiftUI 准备好显示 view 时，它会调用此方法一次
    ///作用： 将需要Preview显示VC 返回出来。
    func makeUIViewController(context: UIViewControllerRepresentableContext<UIBVCPresenter>) -> tmSearchViewController {
        return tmSearchViewController()
    }
    ///UIViewControllerRepresentable  协议中必须实现的方法
    ///    更新UIViewController时候会调用这个方法  可以做一系列l业务实现，
    func updateUIViewController(_ uiViewController: tmSearchViewController, context: UIViewControllerRepresentableContext<UIBVCPresenter>) {
    }
}
struct tmSearchView: View {
    var body: some View {
        UIBVCPresenter()
    }
}

struct tmSearchView_Previews: PreviewProvider {
    static var previews: some View {
        tmSearchView()
    }
}
