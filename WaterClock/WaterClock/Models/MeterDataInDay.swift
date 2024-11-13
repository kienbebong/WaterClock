//
//  MeterDataInDay.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 13/11/24.
//

import Foundation
struct DataInDayResponse: Decodable {
    let results: [MeterDataInDay]
}

struct MeterDataInDay: Codable {
    let METER_NO: String
    let DATA_TIME: String
    let ACTIVE_TOTAL: String
    let FORWARD_TOTAL: String?
    let NEGACTIVE_TOTAL: String?
    let PRESSURE: String?
    let FLOW: String?
    let TEMPERATURE: String?
    let VOLTAGE: String?
    let TIME_SLOT: String?
    let RESET_COUNT: String?
    let SIGNAL: String?
    let VERSION: String?
    let GATEWAY_NO: String?
    let CUSTOMER_CODE: String?
    let CUSTOMER_NAME: String?
    let CUSTOMER_ADDRESS: String?
}


