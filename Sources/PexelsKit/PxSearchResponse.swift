//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation

public struct PxSearchResponse:Codable {
    let page:Int
    let perPage:Int
    let totalResults:Int
    let nextPage:URL?
    let photos:[PxPhoto]
    
    enum CodingKeys: String, CodingKey {
        case page,perPage="per_page",totalResults="total_results",nextPage="next_page",photos
    }
}
