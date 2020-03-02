//
//  tmAddTechDetailedViewController.swift
//  tmAzurLane
//
//  Created by tumao on 2020/3/1.
//  Copyright © 2020 tumao. All rights reserved.
//

import UIKit

class tmAddTechDetailedViewController: UIViewController,tmAddTechDetailedDelegate {
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var numberFirst: UIButton!
    @IBOutlet weak var numberSecond: UITextField!
    @IBOutlet weak var numberThird: UIButton!
    @IBOutlet weak var scale: UIButton!
    @IBOutlet weak var name: UIButton!
    @IBOutlet weak var quality: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var pickBar: UIView!
    
    var visiablePicker = false
    lazy var presenter:tmAddTechDetailedPresenter? = {
        return tmAddTechDetailedPresenter(self)
    }()
    var techNumber:Int?
    
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
    @IBAction func selectSure(_ sender: Any) {
        switch presenter?.value {
        case .name:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 4)
            name.setTitle(presenter?.getPickerArray()[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .numberFirst:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 0)
            numberFirst.setAttributedTitle(NSAttributedString(string: presenter!.getPickerArray()[pickerView.selectedRow(inComponent: 0)]), for: .normal)
        case .numberThird:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 2)
            numberThird.setAttributedTitle(NSAttributedString(string: presenter!.getPickerArray()[pickerView.selectedRow(inComponent: 0)]), for: .normal)
        case .quality:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 5)
            quality.setTitle(presenter?.getPickerArray()[pickerView.selectedRow(inComponent: 0)], for: .normal)
        case .scale:
            presenter?.changeData(pickerView.selectedRow(inComponent: 0), 3)
            scale.setTitle(presenter?.getPickerArray()[pickerView.selectedRow(inComponent: 0)], for: .normal)
        default:
            break
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
        return presenter?.getPickerArray()[row]
    }
}

// MARK: - UIPickerViewDataSource
extension tmAddTechDetailedViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter!.getPickerArrayCount()
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
            
        }
        let sure = UIAlertAction(title: "保存并退出", style: .default) { (UIAlertAction) in
            if !self.checkNumberSecond() {
                self.numberSecondAlert()
            } else {
                
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
            return true
        }
        if text.count<3 {
            return false
        }
        guard Int(text) != nil else {
            return false
        }
        return true
    }
}
