//
//  FootShareView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class FootShareView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("send_invite_link", comment: "Text for sharing the invitation link")
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let urlLabel: UILabel = {
        let label = UILabel()
        label.text = "  https://vtb.com.vn"
        label.backgroundColor = .gray.withAlphaComponent(0.1)
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private let copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "document.on.document"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("or_text", comment: "Text to display for 'or' separator")
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let shareLinkButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("share_link", comment: "Button title for sharing via link"), for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.setImage(UIImage(systemName: "link"), for: .normal)
        button.tintColor = .red
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.red.cgColor
        button.addTarget(self, action: #selector(ShareLink), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        setUpTitle()
        setUpURL()
        setUpCopyButton()
        setUpOrLabel()
        setUpLinkShare()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.greaterThanOrEqualTo(100)
            make.height.equalTo(50)
        }
    }
    
    func setUpURL() {
        addSubview(urlLabel)
        urlLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalTo(titleLabel)
            make.height.equalTo(50)
            make.width.equalTo(400)
        }
    }
    
    func setUpCopyButton() {
        addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.top.equalTo(urlLabel)
            make.trailing.equalTo(urlLabel.snp.trailing)
            make.width.height.equalTo(50)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openLink))
        copyButton.addGestureRecognizer(tapGesture)
    }
    
    func setUpOrLabel() {
        addSubview(orLabel)
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(urlLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpLinkShare() {
        addSubview(shareLinkButton)
        shareLinkButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(400)
            make.height.equalTo(40)
        }
    }
    
    @objc func openLink() {
        UIPasteboard.general.string = urlLabel.text
    }
    
    @objc func ShareLink() {
        let url = URL(string: "https://vtb.com.vn")
        let itemToShare: [Any] = [url]
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                print("chia se thanh cong")
            } else {
                print("chia se khong thanh cong")
            }
        }
        
        if let parentVC = UIApplication.shared.windows.first?.rootViewController {
            parentVC.present(activityViewController, animated: true, completion: nil)
        } else {
            print("khong tim thay controller")
        }
    }

}
