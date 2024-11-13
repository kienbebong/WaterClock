//
//  ChooseDateView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 13/11/24.
//

import UIKit

class ChooseDateView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chỉ số đồng hồ nước theo ngày"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Ngày: "
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    public var dateTF: UITextField = {
        let text = UITextField()
        text.placeholder = "Chọn ngày"
        text.textColor = .black
        text.backgroundColor = .white
        text.layer.borderWidth = 1.5
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "vi_VN")
        picker.maximumDate = Date()
        return picker
    }()
    
    @objc func dateChange(picker: UIDatePicker) {
        dateTF.text = formatDate(date: picker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        return toolbar
    }
    
    @objc func donePressed() {
        dateTF.text = formatDate(date: datePicker.date)
        dateTF.resignFirstResponder()
    }
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tìm kiếm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateTF.inputView = datePicker
        dateTF.inputAccessoryView = createToolbar()
        datePicker.addTarget(self, action: #selector(dateChange(picker:)), for: UIControl.Event.valueChanged)
        dateTF.text = formatDate(date: Date())
        
        setUpTitleLabel()
        setUpChooseLabel()
        setUpTextFiled()
        setUpSearchButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpChooseLabel() {
        addSubview(chooseLabel)
        chooseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    func setUpTextFiled() {
        addSubview(dateTF)
        
        dateTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalTo(chooseLabel.snp.trailing).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(170)
        }
    }
    
    func setUpSearchButton() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(dateTF)
            make.leading.equalTo(dateTF.snp.trailing).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(110)
        }
    }

}
