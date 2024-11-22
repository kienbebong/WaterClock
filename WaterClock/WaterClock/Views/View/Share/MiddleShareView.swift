//
//  MiddelShareView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class MiddleShareView: UIView {
    var parentViewController: UIViewController?

    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = "Quét mã QR bên dưới để tham quan trang web của chúng tôi"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let imageQR: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "QR")
        img.layer.cornerRadius = 30
        img.clipsToBounds = true
        return img
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Chia sẻ ngay", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setImage(UIImage(systemName: "square.and.arrow.up.badge.clock.fill"), for: .normal)
        button.tintColor = .red
        button.backgroundColor = .white
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(OnShareTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpDetail()
        setUpQR()
        setUpShareButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpDetail() {
        addSubview(detailLabel)
        detailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalTo(350)
            make.height.equalTo(80)
        }
    }
    
    func setUpQR() {
        addSubview(imageQR)
        imageQR.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(300)
        }
    }
    
    func setUpShareButton() {
        addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(imageQR.snp.bottom).offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    @objc func OnShareTapped() {
        let image = UIImage(named: "QR")
            
        let itemToShare: [Any] = [image]
            
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
            
        activityViewController.completionWithItemsHandler = { activityType, completed, returnedItems, activityError in
            if completed {
                print("Chia sẻ thành công")
            } else {
                print("Chia sẻ thất bại hoặc bị hủy")
            }
        }
            
        if let parentVC = UIApplication.shared.windows.first?.rootViewController?.presentedViewController ?? UIApplication.shared.windows.first?.rootViewController {
                parentVC.present(activityViewController, animated: true, completion: nil)
        } else {
            print("Không tìm thấy ViewController để trình bày bảng chia sẻ")
        }
    }

}
