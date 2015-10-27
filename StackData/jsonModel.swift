//
//  jsonModel.swift
//  StackData
//
//  Created by BB&T Macbook on 10/26/15.
//  Copyright © 2015 Sathiya Macbook. All rights reserved.
//

import Foundation

class Repository {
    
   
    var accountId: Int?
    var badgeCount: String?
    var bronzeCount: Int?
    var goldCount: Int?
    var silverCount: Int?
    var dateCreated: Int?
    var name: String?
    var isEmployee: Bool?
    var lastAceessDate: Int?
    var lastModifiedDate: Int?
    var link_url: String?
    var location: String?
    var image_url: String?
    var reputation: Int?
    var reputationChangeDay: Int?
    var reputationChangeMonth: Int?
    var reputationChangeQuarter: Int?
    var reputationChangeWeek: Int?
    var reputationChangeYear: Int?
    var userId: String?
    var userType: String?
    var web_Url: String?
    
    init(json: NSDictionary) {
        
        
        self.accountId = json["account_id"] as? Int
        self.badgeCount = json["badge_counts"] as? String
        self.bronzeCount = json["bronze"] as? Int
        self.goldCount = json["gold"] as? Int
        self.silverCount = json["silver"] as? Int
        self.dateCreated = json["creation_date"] as? Int
        self.name = json["display_name"] as? String
        self.isEmployee = json["is_employee"] as? Bool
        self.lastAceessDate = json["last_access_date"] as? Int
        self.lastModifiedDate = json["last_modified_date"] as? Int
        self.link_url = json["link"] as? String
        self.location = json["location"] as? String
        self.image_url = json["profile_image"] as? String
        self.reputation = json["reputation"] as? Int
        self.reputationChangeDay = json["reputation_change_day"] as? Int
        self.reputationChangeMonth = json["reputation_change_month"] as? Int
        self.reputationChangeQuarter = json["reputation_change_quarter"] as? Int
        self.reputationChangeWeek = json["reputation_change_week"] as? Int
        self.reputationChangeYear = json["reputation_change_year"] as? Int
        self.userId = json["user_id"] as? String
        self.userType = json["user_type"] as? String
        self.web_Url = json["website_url"] as? String

    }
}