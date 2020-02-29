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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
    }
    func initData() {
        presenter?.getData(historyId)
        tableview.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
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
