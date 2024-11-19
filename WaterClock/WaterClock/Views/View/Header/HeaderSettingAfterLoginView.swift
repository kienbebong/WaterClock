//
//  HeaderSettingAfterLoginView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 12/11/24.
//
import UIKit

class HeaderSettingAfterLoginView: UIView {

    var onSignOutTapped: (() -> Void)?
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
    
    private let logOutLabel: UILabel = {
        let label = UILabel()
        label.text = "ĐĂNG XUẤT"
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

    private let signOutView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        DataPersistenceManager.shared.fetchAccount { result in
            switch result {
            case .success(let account):
                label.text = account.userName
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUpBackLogo()
        self.setUpSettingImage()
        self.setUpSettingLabel()
        self.setUpUserName()

        self.setUpSignOutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpBackLogo() {
        addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    func setUpSettingImage() {
        addSubview(settingImage)
        settingImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
    }
    
    func setUpSettingLabel() {
        addSubview(settingLabel)
        settingLabel.snp.makeConstraints { make in
            make.top.equalTo(settingImage).offset(5)
            make.leading.equalTo(settingImage).offset(50)
            make.width.equalTo(100)
        }
    }
    
    func setUpUserName() {
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(settingLabel.snp.bottom).offset(5)
            make.leading.equalTo(settingLabel)
        }
    }
    
    func setUpSignOutView() {
        addSubview(signOutView)
        signOutView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        signOutView.addSubview(logoImage)
        logoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(20)
        }
        
        signOutView.addSubview(logOutLabel)
        logOutLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(logoImage).offset(28)
            make.height.equalTo(logoImage)
            make.width.equalTo(200)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignOutTap))
        signOutView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backHome() {
        back?()
    }
    
    @objc private func handleSignOutTap() {
        onSignOutTapped?()
    }


}
