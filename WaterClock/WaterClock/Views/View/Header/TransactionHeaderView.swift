//
//  SettingHeaderView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 4/11/24.
//

import UIKit

class TransactionHeaderView: UIView {

    private let headerImgae: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "bitcoinsign.circle.fill")
        img.tintColor = .white
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let transactionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("transaction_online", comment: "Label for online transactions")
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        let text1 = NSLocalizedString("send_request", comment: "Yêu cầu dịch vụ")
        let text2 = NSLocalizedString("request_service_from_water_company", comment: "Mô tả yêu cầu")
        let fullText = text1 + text2
        
        let attributedText = NSMutableAttributedString(string: fullText)
        let boldRange = (fullText as NSString).range(of: text1)
        let normalRange = (fullText as NSString).range(of: text2)
        
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 16), range: boldRange)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: normalRange)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: boldRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.cyan, range: normalRange)
        
        label.attributedText = attributedText
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
        setUpHeaderImage()
        setUpTransactionLabel()
        setUpDetailLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpHeaderImage() {
        addSubview(headerImgae)
        headerImgae.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(40)
        }
    }
    
    func setUpTransactionLabel() {
        addSubview(transactionLabel)
        transactionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalTo(headerImgae.snp.trailing).offset(15)
            make.width.equalTo(300)
            make.height.equalTo(25)
        }
    }
    
    func setUpDetailLabel() {
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(headerImgae.snp.bottom).offset(15)
            make.leading.equalTo(headerImgae)
            make.width.equalTo(350)
            make.height.equalTo(20)
        }
    }
}
