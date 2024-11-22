//
//  HeaderSearchView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class HeaderSearchView: UIView {
    
    var back: (() -> Void)?

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "BGRB")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .white
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let searchField: UITextField = {
        let text = UITextField()
        text.placeholder = "  Tìm kiếm"
        text.textColor = .white
        text.font = .systemFont(ofSize: 18)
        text.layer.borderWidth = 1
        text.layer.borderColor =  UIColor.white.cgColor
        text.backgroundColor = .gray.withAlphaComponent(0.5)
        text.layer.cornerRadius = 10
        text.clipsToBounds = true
        
        let clearButton = UIButton(type: .system)
        clearButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        clearButton.tintColor = .white
        clearButton.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
            
        clearButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        text.rightView = clearButton
        text.rightViewMode = .always
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        setUpBackGround()
        setUpBackLogo()
        setUpSearchField()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpBackGround() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpBackLogo() {
        addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    func setUpSearchField() {
        addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalTo(backLogoImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(40)
        }
    }

    
    
    @objc private func backHome() {
        back?()
    }
    
    @objc private func clearTextField() {
        searchField.text = ""
    }
}
