//
//  ChooseInstantDateView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 15/11/24.
//

import UIKit

protocol ChooseInstantDateViewDelegate: AnyObject {
    func didTappedSearch(with data: [InstantByDate])
}

class ChooseInstantDateView: UIView {
    
    var data: [InstantByDate]?
    var delegate : ChooseInstantDateViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Báo cáo tình trạng đồng hồ nước"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Ngày bắt đầu"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let chooseLabel2: UILabel = {
        let label = UILabel()
        label.text = "Ngày kết thúc"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    public var dateTF: UITextField = {
        let text = UITextField()
        text.placeholder = "Chọn ngày"
        text.font = .systemFont(ofSize: 15)
        text.textColor = .black
        text.backgroundColor = .white
        text.layer.borderWidth = 1.5
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    public var dateTF2: UITextField = {
        let text = UITextField()
        text.placeholder = "Chọn ngày"
        text.font = .systemFont(ofSize: 15)
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
    
    private let datePicker2: UIDatePicker = {
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
    
    @objc func dateChange2(picker: UIDatePicker) {
        dateTF2.text = formatDate(date: picker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func formatDate2(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        return toolbar
    }
    
    private func createToolbar2() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donePressed2))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        return toolbar
    }
    
    @objc func donePressed() {
        dateTF.text = formatDate(date: datePicker.date)
        dateTF.resignFirstResponder()
    }
    
    @objc func donePressed2() {
        dateTF2.text = formatDate(date: datePicker2.date)
        dateTF2.resignFirstResponder()
    }
    
    @objc func updateDatePicker2MinimumDate() {
        datePicker2.minimumDate = datePicker.date
        dateTF2.text = formatDate(date: datePicker2.date)
    }
    
    private let noLabel: UILabel = {
        let label = UILabel()
        label.text = "Meter No"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    private let meterTextFiled: UITextField = {
        let text = UITextField()
        text.placeholder = "No"
        text.font = .systemFont(ofSize: 15)
        text.textColor = .black
        text.backgroundColor = .white
        text.layer.borderWidth = 1.5
        text.layer.borderColor = UIColor.black.cgColor
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        text.textAlignment = .center
        text.keyboardType = .numberPad
        return text
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Tìm kiếm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleDataInDay), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDataInDay() {
        var dateStart = "\(dateTF.text ?? "")0000"
        var dateEnd = "\(dateTF2.text ?? "")0000"
        dateStart = dateStart.replacingOccurrences(of: "-", with: "")
        dateEnd = dateEnd.replacingOccurrences(of: "-", with: "")
        let meterNo = meterTextFiled.text
        var token: String?
        
        DataPersistenceManager.shared.fetchAccount { result in
            switch result {
            case .success(let account):
                token = account.token
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        if token != nil {
            
            API.shared.getInstantByDate(startDate: dateStart, endDate: dateEnd, meterNo: meterNo ?? "0", token: token!) { result in
                switch result {
                case .success(let instant):
                    self.data = instant
                    self.delegate?.didTappedSearch(with: self.data!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dateTF.inputView = datePicker
        dateTF.inputAccessoryView = createToolbar()
        datePicker.addTarget(self, action: #selector(dateChange(picker:)), for: UIControl.Event.valueChanged)
        dateTF.text = formatDate(date: Date())
        dateTF2.inputView = datePicker2
        dateTF2.inputAccessoryView = createToolbar2()
        datePicker.addTarget(self, action: #selector(dateChange2(picker:)), for: UIControl.Event.valueChanged)
        datePicker.addTarget(self, action: #selector(updateDatePicker2MinimumDate), for: .valueChanged)
        dateTF2.text = formatDate2(date: Date())
        
        setUpTitleLabel()
        setUpChooseLabel()
        setUpTextFiled()
        setUpChooseLabel2()
        setUpTextFiled2()
        setUpMeterLabel()
        setUpMeterTextField()
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
    
    func setUpChooseLabel2() {
        addSubview(chooseLabel2)
        chooseLabel2.snp.makeConstraints { make in
            make.top.equalTo(chooseLabel.snp.bottom).offset(40)
            make.leading.equalTo(chooseLabel)
        }
    }
    
    func setUpTextFiled() {
        addSubview(dateTF)
        
        dateTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    func setUpTextFiled2() {
        addSubview(dateTF2)
        
        dateTF2.snp.makeConstraints { make in
            make.top.equalTo(dateTF.snp.bottom).offset(15)
            make.width.height.equalTo(dateTF)
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpMeterLabel() {
        addSubview(noLabel)
        
        noLabel.snp.makeConstraints { make in
            make.top.equalTo(dateTF2.snp.bottom).offset(30)
            make.leading.equalTo(chooseLabel)
        }
    }
    
    func setUpMeterTextField() {
        addSubview(meterTextFiled)
        
        meterTextFiled.snp.makeConstraints { make in
            make.top.equalTo(dateTF2.snp.bottom).offset(15)
            make.width.height.equalTo(dateTF)
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpSearchButton() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(meterTextFiled.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
}
