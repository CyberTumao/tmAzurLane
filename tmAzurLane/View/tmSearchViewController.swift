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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData()
    }
    
    
    func initData() -> Void {
        tableView.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
    }
}

extension tmSearchViewController:UITableViewDelegate {
    
}

extension tmSearchViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
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
