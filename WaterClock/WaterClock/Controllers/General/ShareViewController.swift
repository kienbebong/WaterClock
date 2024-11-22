//
//  ShareViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 22/11/24.
//

import UIKit

class ShareViewController: UIViewController {
    var headerview: HeaderShareView?
    var middleView: MiddleShareView?
    var footerView: FootShareView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        setUpHeaderView()
        setUpMiddleView()
        setUpFooter()
    }
    
    func setUpHeaderView() {
        headerview = HeaderShareView(frame: .zero)
        view.addSubview(headerview!)
        
        headerview?.back = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        headerview?.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(130)
        }
    }
    
    func setUpMiddleView() {
        middleView = MiddleShareView(frame: .zero)
        view.addSubview(middleView!)
        middleView!.snp.makeConstraints { make in
            make.top.equalTo(headerview!.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
        }
    }
    
    func setUpFooter() {
        footerView = FootShareView(frame: .zero)
        view.addSubview(footerView!)
        footerView!.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-250)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    

   
}
