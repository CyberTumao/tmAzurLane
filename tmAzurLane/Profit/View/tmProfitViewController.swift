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
        self.initData()
    }
    
    func initData() -> Void {
        presenter?.getData(techInfoId)
        tableView.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
    }
}

extension tmProfitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = tmProfitDetailViewController()
        viewController.historyId = presenter?.getHistoryId(atRow: indexPath.row)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension tmProfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getCellNumber(techInfoId)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = presenter?.getDate(atRow: indexPath.row)
        return cell
    }

}
