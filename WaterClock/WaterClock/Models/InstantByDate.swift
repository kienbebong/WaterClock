//
//  InstanceByDate.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 15/11/24.
//

import Foundation

struct InstantByDate: Codable {
    let REALTIME: Date
    let SIGNAL: String
    let VERSION: String
    let REMAIN_BATTERY: String
    let PERIOD: String
    let TYPEWM: String
    let TYPESEND: String
    let TOLERANCESENDEXACTLY: String
    let TIMESEND1_HOUR: String
    let TIMESEND1_MIN: String
    let TIMESEND2_HOUR: String
    let TIMESEND2_MIN: String
    let GATEWAY_NO: String
    let TEMPERATURE: String?
    
    init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            // Decode REALTIME as String and then convert to Date
            let realtimeString = try container.decode(String.self, forKey: .REALTIME)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Assuming the format of the date string
            
            if let date = formatter.date(from: realtimeString) {
                self.REALTIME = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .REALTIME, in: container, debugDescription: "Date string does not match format.")
            }
            
            // Decode other fields
            SIGNAL = try container.decode(String.self, forKey: .SIGNAL)
            VERSION = try container.decode(String.self, forKey: .VERSION)
            REMAIN_BATTERY = try container.decode(String.self, forKey: .REMAIN_BATTERY)
            PERIOD = try container.decode(String.self, forKey: .PERIOD)
            TYPEWM = try container.decode(String.self, forKey: .TYPEWM)
            TYPESEND = try container.decode(String.self, forKey: .TYPESEND)
            TOLERANCESENDEXACTLY = try container.decode(String.self, forKey: .TOLERANCESENDEXACTLY)
            TIMESEND1_HOUR = try container.decode(String.self, forKey: .TIMESEND1_HOUR)
            TIMESEND1_MIN = try container.decode(String.self, forKey: .TIMESEND1_MIN)
            TIMESEND2_HOUR = try container.decode(String.self, forKey: .TIMESEND2_HOUR)
            TIMESEND2_MIN = try container.decode(String.self, forKey: .TIMESEND2_MIN)
            GATEWAY_NO = try container.decode(String.self, forKey: .GATEWAY_NO)
            TEMPERATURE = try container.decodeIfPresent(String.self, forKey: .TEMPERATURE)
        }
}



