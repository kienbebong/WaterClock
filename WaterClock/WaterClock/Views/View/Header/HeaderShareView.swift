//
//  HeaderShareView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class HeaderShareView: UIView {

    var back: (() -> Void)?
    
    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .black
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Chia sẻ ứng dụng"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true   
        
        setUpBackLogo()
        setUpTitle()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
    
    func setUpTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalTo(backLogoImage.snp.trailing).offset(15)
            make.height.equalTo(40)
            make.width.greaterThanOrEqualTo(100)
        }
    }
    
    @objc private func backHome() {
        back?()
    }

}
