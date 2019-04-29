//
//  signupPhoneNumData.swift
//  tiktok
//
//  Created by Bharat shankar on 06/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import Foundation


struct signupMobileData : Codable {
    
    let data1 : data?
    let message : String?
    let otp : Int32?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data1 = "data"
        case message = "message"
        case otp = "otp"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data1 = try values.decodeIfPresent(data.self, forKey: .data1)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        otp = try values.decodeIfPresent(Int32.self, forKey: .otp)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}

struct data : Codable {
    
    let v : Int?
    let id : String?
    let countryCode : String?
    let createdAt : String?
    let info : String?
    let otp : String?
    let status : Int?
    let type : String?
    let updatedAt : String?
    let username : String?
    
    enum CodingKeys: String, CodingKey {
        case v = "__v"
        case id = "_id"
        case countryCode = "countryCode"
        case createdAt = "createdAt"
        case info = "info"
        case otp = "otp"
        case status = "status"
        case type = "type"
        case updatedAt = "updatedAt"
        case username = "username"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        v = try values.decodeIfPresent(Int.self, forKey: .v)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        info = try values.decodeIfPresent(String.self, forKey: .info)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        username = try values.decodeIfPresent(String.self, forKey: .username)
    }
    
}
