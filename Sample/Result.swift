//
//  Result.swift
//  Sample
//

import Foundation

struct Results : Decodable {
    
    let cost : Int?
    let costString : String?
    let desc : String?
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case cost = "cost"
        case desc = "desc"
        case name = "name"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        cost = try? values?.decodeIfPresent(Int.self, forKey: .cost)
        costString = try? values?.decodeIfPresent(String.self, forKey: .cost)
        desc = try? values?.decodeIfPresent(String.self, forKey: .desc)
        name = try? values?.decodeIfPresent(String.self, forKey: .name)
        url = try? values?.decodeIfPresent(String.self, forKey: .url)
    }
    
}
