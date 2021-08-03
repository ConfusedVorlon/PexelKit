//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation

public struct PxPhotoSources: Codable {
    public let original:URL
    public let large2x:URL
    public let large:URL
    public let medium:URL
    public let small:URL
    public let portrait:URL
    public let landscape:URL
    public let tiny:URL
}
