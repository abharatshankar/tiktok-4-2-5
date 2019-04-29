//
//  otpCodableClass.swift
//  tiktok
//
//  Created by Bharat shankar on 19/03/19.
//  Copyright © 2019 Bharat shankar. All rights reserved.
//

import Foundation

struct otpCodableData : Codable {
    
    let message : String?
    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case success = "success"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}
