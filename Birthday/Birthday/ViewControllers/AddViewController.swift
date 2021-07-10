//
//  AddViewController.swift
//  Birthday
//
//  Created by Клим on 04.07.2021.
//

import UIKit

class AddViewController: UIViewController {
    
    let pickerViewAge = UIPickerView()
    let pickerViewMale = UIPickerView()
    let pickerViewDate = UIDatePicker()
    
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var dateTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var maleTextField: UITextField!
    @IBOutlet var instTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerSetting()
        createDatePicker()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        saveProfile()
    }
    
    @IBAction func TextFieldAction(_ sender: Any) {
        showAlert(title: "Введите username", message: "", texfieldVC: instTextField)
    }
    
    
    private func pickerSetting() {
        
        pickerViewAge.dataSource = self
        pickerViewAge.delegate = self
        
        pickerViewMale.dataSource = self
        pickerViewMale.delegate = self
        
        ageTextField.inputView = pickerViewAge
        ageTextField.textAlignment = .center
        
        maleTextField.inputView = pickerViewMale
        maleTextField.textAlignment = .center
        
        pickerViewAge.tag = 1
        pickerViewMale.tag = 2
    }
    
    private func saveProfile() {
        guard let name = nameTextField.text,
              let date = dateTextField.text else { return }
        if name.isEmpty {
            showAlert(title: "Не указано имя", message: "Введите имя", texfieldVC: nameTextField)
        } else if date.isEmpty {
            showAlert(title: "Не указана дата", message: "Введите дату", texfieldVC: dateTextField)
        } else {
            DataManager.shared.saveName(nameTextField.text ?? "", date: dateTextField.text ?? "")
            navigationController?.popViewController(animated: true)
        }
    }
    
    private func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        
        dateTextField.inputView = pickerViewDate
        
        pickerViewDate.datePickerMode = .date
        
        dateTextField.textAlignment = .center
        
    }
    
    @objc func donePressed() {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        dateTextField.text = formatter.string(from: pickerViewDate.date)
        self.view.endEditing(true)
    }
    
    private func showAlert(title: String, message: String, texfieldVC: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "OK", style: .default) { _ in
            let textField = alert.textFields?.first
            texfieldVC.text = textField?.text
        }
        alert.addAction(action)
        alert.addAction(cancel)
        alert.addTextField { textField in
        }
        present(alert, animated: true, completion: nil)
        
    }
}
extension AddViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return Information.age.count
        case 2:
            return Information.male.count
        default: return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return Information.age[row]
        case 2:
            return Information.male[row]
        default:
            return "No information"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            ageTextField.text = Information.age[row]
            ageTextField.resignFirstResponder()
        case 2:
            maleTextField.text = Information.male[row]
            maleTextField.resignFirstResponder()
        default: break
        }
        
    }
}
