//
//  SignInViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(image)
        image.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(85)
            make.width.height.equalTo(80)
        }
        
        view.addSubview(VTBLabel)
        VTBLabel.snp.makeConstraints { make in
            make.top.equalTo(image).offset(20)
            make.leading.equalTo(image).offset(85)
        }
        
        view.addSubview(companyLabel)
        companyLabel.snp.makeConstraints { make in
            make.top.equalTo(VTBLabel).offset(40)
            make.leading.equalTo(VTBLabel)
        }
        
        view.addSubview(skipButton)
        skipButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(110)
            make.width.equalTo(80)
        }
        
        view.addSubview(signLabel)
        signLabel.snp.makeConstraints { make in
            make.top.equalTo(image).offset(130)
            make.leading.equalToSuperview().offset(20)
        }
        
        view.addSubview(signDetailLabel)
        signDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(signLabel).offset(40)
            make.leading.equalTo(signLabel)
            make.width.equalToSuperview().offset(-45)
        }
        
        view.addSubview(phoneNumberTextField)
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(signDetailLabel).offset(60)
            make.width.equalToSuperview().offset(-45)
            make.height.equalTo(50)
            make.leading.equalTo(signLabel)
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField).offset(80)
            make.width.height.equalTo(phoneNumberTextField)
            make.leading.equalTo(phoneNumberTextField)
        }
        
        view.addSubview(clauseLabel)
        clauseLabel.snp.makeConstraints { make in
            make.top.equalTo(continueButton).offset(60)
            make.leading.equalTo(phoneNumberTextField)
            make.width.equalTo(signDetailLabel)
        }
        
        view.addSubview(orLabel)
        orLabel.snp.makeConstraints { make in
            make.top.equalTo(clauseLabel).offset(40)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(dvcImage)
        dvcImage.snp.makeConstraints { make in
            make.top.equalTo(orLabel).offset(90)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(signDetailLabel)
        }
    }
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "waterClock")
        return image
    }()
    
    private let VTBLabel: UILabel = {
       let label = UILabel()
        label.text = "VTB"
        label.textColor = .red
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()

    private let companyLabel: UILabel = {
       let label = UILabel()
        label.text = "Công ty cổ phần Viettronics Tân Bình"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Bỏ qua", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.gray .cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonTapped() {
        self.navigationController?.popViewController(animated: true)

    }
    
    private let signLabel: UILabel = {
        let label = UILabel()
        label.text = "Đăng nhập hoặc tạo tài khoản"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        return label
    }()
    
    private let signDetailLabel: UILabel = {
        let label = UILabel()
        
        let text1 = "Vui lòng nhập "
        let text2 = "số điện thoại "
        let text3 = "để đăng kí hoặc đăng nhập vào ứng dụng."
        let fullText = text1 + text2 + text3
        
        let attributedText = NSMutableAttributedString(string: fullText)
        
        let boldRange = (fullText as NSString).range(of: text2)
        let normalRange1 = (fullText as NSString).range(of: text1)
        let normalRange3 = (fullText as NSString).range(of: text3)
        
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: boldRange)

        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: normalRange1)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: normalRange3)
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.textColor = UIColor(red: 0/255, green: 0/255, blue: 139/255, alpha: 1.0)
        return label
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Số điện thoại"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15)
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 10
        textField.keyboardType = .phonePad
        textField.attributedPlaceholder = NSAttributedString(string: "Số điện thoại", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.setTitle("TIẾP TỤC", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleShadowColor(UIColor.white, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let clauseLabel: UILabel = {
        let label = UILabel()
        let text1 = "Bằng việc đăng nhập, đăng ký, bạn đồng ý với các "
        let text2 = "giao dịch điện tử của VTB"
        let fullText = text1 + text2
        let attributedText = NSMutableAttributedString(string: fullText)
        let tappableRange = (fullText as NSString).range(of: text2)
        let normalRange = (fullText as NSString).range(of: text1)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 15), range: tappableRange)
        attributedText.addAttribute(.font, value: UIFont.systemFont(ofSize: 15), range: normalRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: normalRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: tappableRange)
            label.attributedText = attributedText
            label.isUserInteractionEnabled = true
        label.numberOfLines = 0
        return label
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "----------Hoặc đăng nhập bằng----------"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private let dvcImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "congdvc")
        return image
    }()
}
