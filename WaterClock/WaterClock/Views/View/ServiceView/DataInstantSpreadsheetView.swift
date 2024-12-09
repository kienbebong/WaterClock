//
//  DataInstantSpreadsheetView.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 15/11/24.
//

import UIKit
import SpreadsheetView


class DataInstantSpreadsheetView: UIView {

    let spreadsheetView = SpreadsheetView()
    var receiveData: [InstantByDate]?
    
    let dataName = [
        NSLocalizedString("TIME", comment: "Mô tả thời gian"),
        NSLocalizedString("SIGNAL_STRENGTH", comment: "Mô tả cường độ tín hiệu"),
        NSLocalizedString("DEVICE_VERSION", comment: "Mô tả phiên bản đồng hồ"),
        NSLocalizedString("TEMPERATURE_C", comment: "Mô tả nhiệt độ (độ C)"),
        NSLocalizedString("PERIOD_MIN", comment: "Mô tả chu kỳ (phút)")
    ]

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSpreadsheetView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUpSpreadsheetView() {
        addSubview(spreadsheetView)
        spreadsheetView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        
        spreadsheetView.delegate = self
        spreadsheetView.dataSource = self
    }
    
    func updateData(_ data: [InstantByDate]){
        receiveData = data
        spreadsheetView.reloadData()
    }
    
    
    
}
extension DataInstantSpreadsheetView: SpreadsheetViewDelegate, SpreadsheetViewDataSource {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        return 40
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        return 180
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return dataName.count
    }
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        let totalColumns = dataName.count
        
        let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
        let headerIndex = indexPath.row % totalColumns
        
        if indexPath.column == 0 {
            cell.label.text = dataName[headerIndex]
        } else if let data = receiveData {
            // Cột dữ liệu
            switch headerIndex {
            case 0:
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                cell.label.text = dateFormatter.string(from: (data.first?.REALTIME)!)
            case 1:
                cell.label.text = data.first?.SIGNAL
            case 2:
                cell.label.text = data.first?.VERSION
            case 3:
                cell.label.text = data.first?.TEMPERATURE ?? "N/A"
            case 4:
                cell.label.text = data.first?.PERIOD
            default:
                cell.label.text = ""
            }
        }
        
        return cell
    }

}

