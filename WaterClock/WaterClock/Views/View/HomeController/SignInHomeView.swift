//
//  SignInHomeView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 30/10/24.
//

import UIKit

class SignInHomeView: UIView {
    
    var onSignInTapped: (() -> Void)?
    
    let featureView = FeatureHomeView()

    private let logInLabel: UILabel = {
        let label = UILabel()
        let text1 = "Đăng nhập tài khoản"
        let text2 = " VTB"
        let fullText = text1 + text2
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let normalRange = (fullText as NSString).range(of: text1)
        let boldRange = (fullText as NSString).range(of: text2)
        
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: boldRange)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 20), range: normalRange)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.red, range: boldRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: normalRange)
        
        label.attributedText = attributedText
        label.textAlignment = .center
        return label
    }()
    
    private let discoverLabel: UILabel = {
        let label = UILabel()
        label.text = "Khám phá tất cả tính năng mới"
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "waterClock")
        return image
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("ĐĂNG NHẬP NGAY", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(systemName: "person.circle"), for: .normal)
        button.tintColor = .white
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
        button.layer.cornerRadius = 10
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.imagePadding = 10
        button.addTarget(self, action: #selector(handleSignInViewTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLayout()
        setUplogInLabel()
        setUpDiscoverLabel()
        setUpImage()
        setUpFeatures()
        setUpSignInButton()
    }
    
    func setUpLayout() {
        self.layer.cornerRadius = 60
        self.clipsToBounds = true
        self.backgroundColor = UIColor(patternImage: .bgwhite1)
    }
    
    func setUplogInLabel() {
        addSubview(logInLabel)
        logInLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    func setUpDiscoverLabel() {
        addSubview(discoverLabel)
        discoverLabel.snp.makeConstraints { make in
            make.top.equalTo(logInLabel).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    func setUpImage() {
        addSubview(image)
        image.snp.makeConstraints { make in
            make.top.equalTo(discoverLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.width.height.equalTo(150)
        }
    }
    
    func setUpFeatures() {
        addSubview(featureView)
        featureView.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.height.equalTo(100)
        }
    }
    
    func setUpSignInButton() {
        addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(featureView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSignInViewTap() {
        onSignInTapped?()
    }

}
