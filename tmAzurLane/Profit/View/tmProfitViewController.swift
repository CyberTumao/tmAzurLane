//
//  tmProfitViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/2/28.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmProfitViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "tmProfitViewCell"
    lazy var presenter:tmProfitPresenter? = {
        return tmProfitPresenter()
    }()
    lazy var techInfoId:Int = {
        return 0
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initData() -> Void {
        tableView.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
    }
}

extension tmProfitViewController: UITableViewDelegate {
    
}

extension tmProfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getCellNumber(techInfoId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        return cell
    }

}
