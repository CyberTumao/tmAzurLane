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
    @IBOutlet weak var datePickerView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let cellId = "tmProfitTableViewCell"
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
    
    // MARK: - Button Click
    @IBAction func cancel(_ sender: Any) {
        datePickerView.isHidden = true
    }
    
    @IBAction func sure(_ sender: Any) {
        datePickerView.isHidden = true
        addDate()
    }
    
    func initData() -> Void {
        presenter?.getData(techInfoId)
        tableView.register(UINib.init(nibName: cellId, bundle:.main), forCellReuseIdentifier: cellId)
    }
}

// MARK: - UITableViewDelegate
extension tmProfitViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == presenter?.getCellNumber(techInfoId) {
            datePickerView.isHidden = false
        } else {
            let viewController = tmProfitDetailViewController()
            viewController.historyId = presenter?.getHistoryId(atRow: indexPath.row)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - UITableViewDataSource
extension tmProfitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.getCellNumber(techInfoId)+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! tmProfitTableViewCell
        if indexPath.row == presenter?.getCellNumber(techInfoId) {
            cell.addView.isHidden = false
        } else {
            cell.addView.isHidden = true
            cell.dateText.text = presenter?.getDate(atRow: indexPath.row)
        }
        return cell
    }

}

// MARK: - AddProfit
extension tmProfitViewController {
    func addDate() {
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        let date = formatter.string(from: datePicker.date)
        presenter?.addProfit(withTechInfoId: techInfoId, date: date)
        presenter?.reloadData(techInfoId)
        tableView.reloadData()
    }
}
