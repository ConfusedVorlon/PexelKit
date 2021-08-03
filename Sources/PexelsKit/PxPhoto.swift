//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation

public struct PxPhoto: Codable {
    public let id:Int
    public let width:Int
    public let height:Int
    public let url:URL
    public let photographer:String
    public let photographerUrl:URL
    public let photographerId:Int
    public let averageHexColour:String
    public let sources:PxPhotoSources
    
    enum CodingKeys: String, CodingKey {
        case id,width,height,url,photographer,
             photographerUrl="photographer_url",photographerId="photographer_id",
             averageHexColour="avg_color",sources="src"
    }
}
