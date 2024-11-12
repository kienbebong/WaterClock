//
//  Account.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 12/11/24.
//

import Foundation
struct Account: Codable{
    let CODE: String
    let MESSAGE: String
    let USER_ID: String
    let USER_ACCOUNT: String
    let USER_NAME: String
    let USER_ADDRESS: String?
    let USER_TEL: String?
    let USER_EMAIL: String?
    let USER_TYPE: String
    let LASTACTIVE_TIME: String
    let TOKEN: String
    let TOKEN_EXPIRED: String
    let ROLE_NAME: String
}


