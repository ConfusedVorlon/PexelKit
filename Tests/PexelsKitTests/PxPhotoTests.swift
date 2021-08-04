//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import XCTest
import Foundation

@testable import PexelsKit

final class PxPhotoTests: XCTestCase {

    
    func testDecodingPhPhoto() {
        
        let string = """
            {
              "id": 2014422,
              "width": 3024,
              "height": 3025,
              "url": "https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/",
              "photographer": "Joey Farina",
              "photographer_url": "https://www.pexels.com/@joey",
              "photographer_id": 680589,
              "avg_color": "#978E82",
              "src": {
                "original": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg",
                "large2x": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
                "large": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=650&w=940",
                "medium": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=350",
                "small": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&h=130",
                "portrait": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=1200&w=800",
                "landscape": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&fit=crop&h=627&w=1200",
                "tiny": "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280"
              }
            }
            """
        let data = string.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let photo = try! decoder.decode(PxPhoto.self, from: data)
        
        XCTAssertEqual(photo.id, 2014422)
        XCTAssertEqual(photo.width, 3024)
        XCTAssertEqual(photo.height, 3025)
        XCTAssertEqual(photo.photoPage, URL(string:"https://www.pexels.com/photo/brown-rocks-during-golden-hour-2014422/")!)
        XCTAssertEqual(photo.photographer, "Joey Farina")
        XCTAssertEqual(photo.photographerUrl, URL(string:"https://www.pexels.com/@joey")!)
        XCTAssertEqual(photo.photographerId, 680589)
        XCTAssertEqual(photo.averageHexColour, "#978E82")
        

        XCTAssertEqual(photo.sources.original, URL(string: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg")!)
        XCTAssertEqual(photo.sources.tiny, URL(string: "https://images.pexels.com/photos/2014422/pexels-photo-2014422.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280")!)
    }
    
    
}


