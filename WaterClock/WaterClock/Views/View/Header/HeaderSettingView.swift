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
    var back: (() -> Void)?
    
    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .white
        img.isUserInteractionEnabled = true
        return img
    }()

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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "ĐĂNG NHẬP NGAY"
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
        
        self.setUpBackLogo()
        self.setUpSettingImage()
        self.setUpSettingLabel()
        self.setUpSignInView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpBackLogo() {
        addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(93)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    func setUpSettingImage() {
        addSubview(settingImage)
        settingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalTo(backLogoImage.snp.trailing).offset(20)
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
            make.width.equalTo(180)
            make.height.equalTo(50)
        }
        
        signInView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }
        
        signInView.addSubview(logInLabel)
        logInLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage).offset(28)
            make.height.equalTo(logoImage)
            make.width.equalTo(200)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignInViewTap))
        signInView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backHome() {
        back?()
    }
    
    @objc private func handleSignInViewTap() {
        onSignInTapped?()
    }

}
