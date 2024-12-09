//
//  HeaderOnlChargeView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class HeaderOnlChargeView: UIView {
    var back: (() -> Void)?

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("ONLINE_PAYMENT", comment: "Thanh toán trực tuyến cho sản phẩm hoặc dịch vụ")
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    private let backLogoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "arrow.backward")
        img.tintColor = .gray
        img.isUserInteractionEnabled = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        setUpBackLogo()
        setUpTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpBackLogo() {
        self.addSubview(backLogoImage)
        backLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(10)
            make.width.height.equalTo(28)
        }
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(backHome))
        backLogoImage.addGestureRecognizer(tapGesture1)
    }
    
    func setUpTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
    
    @objc private func backHome() {
        back?()
    }
}
