//
//  File.swift
//  
//
//  Created by Rob Jonson on 03/08/2021.
//

import Foundation
import Alamofire
import HSHelpers

public class PxSearch {
    let searchTerm:String?
    let perPage:Int
    let completion:(PxResult)->Void
    
    public var photos:[PxPhoto]=[]
    public var maxPhotos:Int?
    
    init (searchTerm: String? = nil, perPage: Int = 80, completion: @escaping (PxResult)->Void){
        self.searchTerm = searchTerm
        self.perPage = [1, perPage, 80].sorted()[1]
        self.completion = completion
    }
    
    private var fetching:Bool = false
    private var lastResult:PxSearchResponse?
    public func getNextPage() {
        if fetching {return}
        
        if let maxPhotos = maxPhotos, photos.count >= maxPhotos {
            return
        }
        
        if let lastResult = lastResult, lastResult.nextPage.isNil {
            //not the first search, and no more pages available
            return
        }
        
        fetching = true
        
        let url = lastResult?.nextPage ?? initialUrl
        let headers = HTTPHeaders(["Authorization":PxClient.shared.config.auth])
        
        AF.request(url,
                   method: .get,
                   headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of:PxSearchResponse.self) {
                [weak self] response in
                self?.fetching = false
                
                switch response.result {
                case .failure(let error):
                    if let string = response.data?.utf8String {
                        print("Pexel failure for : \(url)")
                        print("Response:")
                        print(string)
                    }
                    self?.completion(PxResult.failure(error))
                    break
                case .success(let response):
                    self?.process(response)
                    
                    if let self = self {
                        self.completion(PxResult.success(self))
                    }
                    break
                }
            }
    }
    
    private func process(_ response:PxSearchResponse){
        photos.append(contentsOf: response.photos)
        maxPhotos = response.totalResults
        lastResult = response
    }
    
    private var initialUrl:URL {
        var urlC:URLComponents!
        
        if let searchTerm = searchTerm {
            urlC = URLComponents(string: "https://api.pexels.com/v1/search")
            urlC["query"]=searchTerm
        }
        else {
            urlC = URLComponents(string: "https://api.pexels.com/v1/curated")
        }
        urlC["page"]="1"
        urlC["per_page"]="\(perPage)"
        
        return urlC.url!
    }
}
