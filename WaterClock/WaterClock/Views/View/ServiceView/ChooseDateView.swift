//
//  ChooseDateView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 13/11/24.
//

import UIKit


protocol ChooseDateViewDelegate: AnyObject {
    func didTappedSearch(with data: [MeterDataInDay])
}

class ChooseDateView: UIView {
    
    var dataInDay: [MeterDataInDay]?
    var delegate : ChooseDateViewDelegate?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chỉ số đồng hồ nước theo ngày"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let chooseLabel: UILabel = {
        let label = UILabel()
        label.text = "Ngày"
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
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    private func createToolbar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        toolbar.translatesAutoresizingMaskIntoConstraints = false
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
        var date = "\(dateTF.text ?? "")0000"
        date = date.replacingOccurrences(of: "-", with: "")
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
            
            API.shared.getDataInDay(date: date, meterNo: meterNo!, token: token!) { result in
                switch result {
                case .success(let data):
                    self.dataInDay = data
                    self.delegate?.didTappedSearch(with: data)
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
        
        setUpTitleLabel()
        setUpChooseLabel()
        setUpTextFiled()
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
    
    func setUpTextFiled() {
        addSubview(dateTF)
        
        dateTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalTo(chooseLabel.snp.trailing).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    func setUpMeterLabel() {
        addSubview(noLabel)
        
        noLabel.snp.makeConstraints { make in
            make.top.equalTo(chooseLabel)
            make.leading.equalTo(dateTF.snp.trailing).offset(10)
        }
    }
    
    func setUpMeterTextField() {
        addSubview(meterTextFiled)
        
        meterTextFiled.snp.makeConstraints { make in
            make.top.equalTo(dateTF)
            make.leading.equalTo(noLabel.snp.trailing).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(140)
        }
    }
    
    func setUpSearchButton() {
        addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(dateTF.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    

}
