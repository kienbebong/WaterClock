//
//  FeatureTransactionView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class FeatureTransactionView: UIView {
    var tappedPayment: (() -> Void)?

    private let onlinePayButton: UIButton = {
        let button = UIButton()
        button.setTitle("Thanh toán trực tuyến", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "dollarsign.bank.building.fill"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .orange.withAlphaComponent(1.2)
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePadding = 10
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(checkPayment), for: .touchUpInside)
        return button
    }()
    
    private let fixButton: UIButton = {
        let button = UIButton()
        button.setTitle("Báo cáo sửa nước", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "wrench.and.screwdriver.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePadding = 10
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let indexButton: UIButton = {
        let button = UIButton()
        button.setTitle("Báo chỉ số nước", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "chart.line.text.clipboard.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePadding = 10
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpOnlinePayButton()
        setUpFixButton()
        setUpIndexButton()
    }
    
    func setUpOnlinePayButton() {
        addSubview(onlinePayButton)
        onlinePayButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(70)
        }
    }
    
    func setUpFixButton() {
        addSubview(fixButton)
        fixButton.snp.makeConstraints { make in
            make.top.equalTo(onlinePayButton.snp.bottom).offset(20)
            make.leading.equalTo(onlinePayButton)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(onlinePayButton)
        }
    }
    
    func setUpIndexButton() {
        addSubview(indexButton)
        indexButton.snp.makeConstraints { make in
            make.top.equalTo(fixButton)
            make.trailing.equalTo(onlinePayButton)
            make.width.equalTo(UIScreen.main.bounds.width / 3)

            make.height.equalTo(onlinePayButton)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func checkPayment() {
        tappedPayment?()
    }
    
    

}
