//
//  OnlineChargeViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class OnlineChargeViewController: UIViewController {
    
    var headerView: HeaderOnlChargeView?
    
    private let redView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Thanh toán cho điểm người dùng nước"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let textFiled: UITextField = {
        let text = UITextField()
        text.placeholder = "Nhập mã khách hàng cần thanh toán"
        text.attributedPlaceholder = NSAttributedString(
               string: "Nhập mã khách hàng cần thanh toán",
               attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
           )
        text.textColor = .gray
        text.layer.cornerRadius = 10
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.borderWidth = 1.5
        return text
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("Kiểm tra nợ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpRedView()
        setUpHeaderView()
        setUpDetailLabel()
        setUpTextFiled()
        setUpCheckButton()
    }
    
    func setUpRedView() {
        view.addSubview(redView)
        redView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
    }
    
    func setUpHeaderView() {
        headerView = HeaderOnlChargeView(frame: .zero)
        redView.addSubview(headerView!)
        headerView?.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        
        headerView?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func setUpDetailLabel() {
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView!.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(400)
        }
    }
    
    func setUpTextFiled() {
        view.addSubview(textFiled)
        textFiled.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
    }
    
    func setUpCheckButton() {
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(textFiled.snp.bottom).offset(20)
            make.leading.trailing.equalTo(textFiled)
            make.height.equalTo(50)
        }
    }
}
