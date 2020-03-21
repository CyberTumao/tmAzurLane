//
//  tmAddTechDetailedViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/1.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

typealias saveDataResultBlock = (Bool) -> Void

class tmAddTechDetailedViewController: UIViewController {
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var numberFirst: UIButton!
    @IBOutlet weak var numberSecond: UITextField!
    @IBOutlet weak var numberThird: UIButton!
    @IBOutlet weak var scale: UIButton!
    @IBOutlet weak var name: UIButton!
    @IBOutlet weak var quality: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickBar: UIView!
    @IBOutlet weak var additionLabel: UILabel!
    @IBOutlet weak var additionButton: UIButton!
    
    var visiablePicker = false
    lazy var presenter:tmAddTechDetailedPresenter? = {
        return tmAddTechDetailedPresenter(self)
    }()
    var techNumber:Int?
    var result:saveDataResultBlock?
    
    convenience init(_ techNumber:Int) {
        self.init()
        self.techNumber = techNumber
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Button Click
    @IBAction func scaleClick(_ sender: Any) {
        presenter?.setAddTechValue(.scale)
        viewControl(3)
    }
    @IBAction func quit(_ sender: Any) {
        quitAlertController()
    }
    @IBAction func quitWithData(_ sender: Any) {
        if !checkNumberSecond() {
            numberSecondAlert()
        } else {
            presenter?.saveData(withTechNumber: techNumber!)
        }
    }
    @IBAction func name(_ sender: Any) {
        presenter?.setAddTechValue(.name)
        viewControl(4)
    }
    @IBAction func numberFirstClick(_ sender: Any) {
        presenter?.setAddTechValue(.numberFirst)
        viewControl(0)
    }
    @IBAction func quliatyClick(_ sender: Any) {
        presenter?.setAddTechValue(.quality)
        viewControl(5)
    }
    @IBAction func numberThirdClick(_ sender: Any) {
        presenter?.setAddTechValue(.numberThird)
        viewControl(2)
    }    
    @IBAction func additionButtonClick(_ sender: Any) {
        presenter?.setAddTechValue(.addition)
        viewControl(6)
    }
    @IBAction func selectSure(_ sender: Any) {
        switch presenter?.value {
        case .name:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 4)
            name.setTitle(presenter?.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .numberFirst:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 0)
            numberFirst.setAttributedTitle(NSAttributedString(string: presenter!.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)]), for: .normal)
            if pickerView.selectedRow(inComponent: 0) == 1 {
                if techNumber == 1 {
                    additionButton.setTitle(nameOfTechShips.Neptune.value, for: .normal)
                } else {
                    additionButton.setTitle(nameOfTechShips.Seattle.value, for: .normal)
                }
                additionLabel.isHidden = false
                additionButton.isHidden = false
            } else {
                additionLabel.isHidden = true
                additionButton.isHidden = true
            }
        case .numberThird:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 2)
            numberThird.setAttributedTitle(NSAttributedString(string: presenter!.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)]), for: .normal)
        case .quality:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 5)
            quality.setTitle(presenter?.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .scale:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 3)
            scale.setTitle(presenter?.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .addition:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 6)
            additionButton.setTitle(presenter?.getPickerArray(techNumber!)[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .none:
            return
        }
        visiablePickerView()
    }
    @IBAction func selectCancel(_ sender: Any) {
        visiablePickerView()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if numberSecond.isFirstResponder {
            numberSecond.resignFirstResponder()
        }
    }
}

// MARK: - UIPickerViewDelegate
extension tmAddTechDetailedViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter?.getPickerArray(techNumber!)[row]
    }
}

// MARK: - UIPickerViewDataSource
extension tmAddTechDetailedViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter!.getPickerArrayCount(techNumber!)
    }
}

// MARK: - UITextFieldDelegate
extension tmAddTechDetailedViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let count = textField.text?.count else { return false }
        if count>2 && !string.isEmpty {
            return false
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - tmAddTechDetailedDelegate
extension tmAddTechDetailedViewController: tmAddTechDetailedDelegate {
    
    func saveDataSuccess() {
        if let result = result {
            result(true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func saveDataFailure() {
        if let result = result {
            result(false)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Alert
extension tmAddTechDetailedViewController {
    func viewControl(_ row:Int) {
        if numberSecond.isFirstResponder {
            numberSecond.resignFirstResponder()
        } else {
            visiablePickerView()
            pickerView.reloadAllComponents()
            pickerView.selectRow(presenter!.getData(row), inComponent: 0, animated: false)
        }
    }
    func visiablePickerView() {
        if visiablePicker {
            transparentView.isHidden = true
            pickBar.isHidden = true
            pickerView.isHidden = true
        } else {
            transparentView.isHidden = false
            pickerView.isHidden = false
            pickBar.isHidden = false
        }
        visiablePicker = !visiablePicker
    }
    func quitAlertController() {
        let alert = UIAlertController(title: nil, message: "编辑内容未保存", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let quit = UIAlertAction(title: "直接退出", style: .default) { (UIAlertAction) in
            self.dismiss(animated: true, completion: nil)
        }
        let sure = UIAlertAction(title: "保存并退出", style: .default) { (UIAlertAction) in
            if !self.checkNumberSecond() {
                self.numberSecondAlert()
            } else {
                self.presenter?.saveData(withTechNumber: self.techNumber!)
                self.dismiss(animated: true, completion: nil)
            }
        }
        alert.addAction(cancel)
        alert.addAction(quit)
        alert.addAction(sure)
        self.present(alert, animated: true, completion: nil)
    }
    func numberSecondAlert() {
        let alert = UIAlertController(title: nil, message: "编号需要三位数字", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "知道了", style: .cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    func checkNumberSecond() -> Bool {
        guard let text = numberSecond.text else {
            return false
        }
        if text.isEmpty {
            presenter?.changeData(759, 1)
            return true
        }
        if text.count<3 {
            return false
        }
        guard let number = Int(text) else {
            return false
        }
        presenter?.changeData(number, 1)
        return true
    }
}
