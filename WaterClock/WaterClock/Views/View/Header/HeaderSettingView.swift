//
//  HeaderSettingView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 1/11/24.
//

import UIKit
import SnapKit

class HeaderSettingView: UIView {
    var onSignInTapped: (() -> Void)?

    private let settingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "gearshape.fill")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "CÀI ĐẶT"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    private let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "ĐĂNG NHẬP NGAY"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .blue
        return image
    }()

    private let signInView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpSettingImage()
        self.setUpSettingLabel()
        self.setUpSignInView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpSettingImage() {
        addSubview(settingImage)
        settingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    func setUpSettingLabel() {
        addSubview(settingLabel)
        settingLabel.snp.makeConstraints { make in
            make.top.equalTo(settingImage).offset(5)
            make.leading.equalTo(settingImage).offset(40)
            make.width.equalTo(100)
        }
    }
    
    func setUpSignInView() {
        addSubview(signInView)
        signInView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(230)
            make.height.equalTo(50)
        }
        
        signInView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(30)
        }
        
        signInView.addSubview(logInLabel)
        logInLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage).offset(38)
            make.height.equalTo(logoImage)
            make.width.equalTo(200)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignInViewTap))
        signInView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleSignInViewTap() {
        onSignInTapped?()
    }

}
