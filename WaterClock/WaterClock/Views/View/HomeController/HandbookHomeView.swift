//
//  handbookHomeView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 31/10/24.
//

import UIKit

class HandbookHomeView: UIView {
    
    private let handbookLabel: UILabel = {
        let label = UILabel()
        label.text = "CẨM NANG ẤN PHẨM"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Giúp bạn tra cứu thêm thong tin, hiểu biết về ngành nước"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setBackGround()
        setUpHandbookLabel()
        setUpDetailLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpLayout() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func setBackGround() {
        let image = UIImageView()
        image.image = UIImage(named: "handbook3")
        image.contentMode = .scaleAspectFill
        addSubview(image)
        
        image.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    func setUpHandbookLabel() {
        addSubview(handbookLabel)
        handbookLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
    }
    
    func setUpDetailLabel() {
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(handbookLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(250)
        }
    }
}
