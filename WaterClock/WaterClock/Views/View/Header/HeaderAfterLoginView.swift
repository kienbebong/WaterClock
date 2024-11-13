//
//  HeaderAfterLoginView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 12/11/24.
//

import SnapKit
import UIKit

class HeaderAfterLoginView: UIView {
    var onSettingInTapped: (() -> Void)?
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BGRB")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let glassLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .white
        return image
    }()
    
    private let phoneLogo: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "phone.fill")
        image.tintColor = .white
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private let signInImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logoLogIn")
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true

        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        DataPersistenceManager.shared.fetchAccount { result in
            switch result {
            case .success(let account):
                label.text = "Tài khoản: \(account.userName ?? "")"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        DataPersistenceManager.shared.fetchAccount { result in
            switch result {
            case .success(let account):
                label.text = "ID: \(account.userId ?? "")"
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        label.textColor = .white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let fixButton: UIButton = {
        let button = UIButton()
        button.setTitle("Báo sửa nước", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange.withAlphaComponent(0.9)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        setUpBackground()
        setUpPhoneLogo()
        setUpGlassLogo()
        setUpSignInImage()
        setUpAccountView()
        setUpFixButton()
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(openSettingConTroller))
        signInImage.addGestureRecognizer(tapGesture1)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpPhoneLogo() {
        addSubview(phoneLogo)
        phoneLogo.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(30)
        }
    }
    
    func setUpGlassLogo() {
        addSubview(glassLogo)
        glassLogo.snp.makeConstraints { make in
            make.top.equalTo(phoneLogo)
            make.trailing.equalTo(phoneLogo.snp.leading).offset(-60)
            make.width.height.equalTo(phoneLogo)
        }
    }
    
    func setUpBackground() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpSignInImage() {
        addSubview(signInImage)
        signInImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(15)
            make.width.height.equalTo(60)
        }
    }
    
    func setUpAccountView() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(signInImage)
            make.leading.equalTo(signInImage.snp.trailing).offset(20)
        }
        
        addSubview(idLabel)
        idLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.equalTo(nameLabel)
        }
    }
    
    func setUpFixButton() {
        addSubview(fixButton)
        fixButton.snp.makeConstraints { make in
            make.top.equalTo(phoneLogo.snp.bottom).offset(10)
            make.leading.equalTo(glassLogo).offset(-10)
            make.trailing.equalTo(phoneLogo).offset(10)
            make.height.equalTo(50)
        }
    }
    
    @objc private func openSettingConTroller() {
        onSettingInTapped?()
    }

}
