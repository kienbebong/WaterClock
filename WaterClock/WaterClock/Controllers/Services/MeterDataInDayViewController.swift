//
//  PaymentViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 7/11/24.
//

import UIKit

class MeterDataInDayViewController: UIViewController, ChooseDateViewDelegate {
    var chooseDateView: ChooseDateView?
    var dataView: DataSpreadSheetView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChoosDateView()
    }
    
    func setUpChoosDateView() {
        chooseDateView = ChooseDateView(frame: .zero)
        view.addSubview(chooseDateView!)
        chooseDateView?.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        chooseDateView?.delegate = self
    }
    
    func didTappedSearch(with data: [MeterDataInDay]) {
            DispatchQueue.main.async {
                if let existingView = self.dataView {
                    existingView.spreadsheetView.isHidden = true
                    existingView.spreadsheetView.removeFromSuperview()
                }
                self.dataView = DataSpreadSheetView(frame: .zero)
                self.view.addSubview(self.dataView!)
                self.dataView?.snp.makeConstraints { make in
                    make.top.equalTo(self.chooseDateView!.snp.bottom).offset(20)
                    make.leading.equalToSuperview().offset(20)
                    make.trailing.equalToSuperview().offset(-20)
                    make.height.greaterThanOrEqualTo(400)
                }
                self.dataView?.updateData(data)
                self.dataView?.spreadsheetView.reloadData()
                
            }
    }


}
