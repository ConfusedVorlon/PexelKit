import Foundation

public typealias PxResult = Result<PxSearch,Error>

open class PxClient{
    public static let shared = PxClient()
    
    public struct Config {
        public init(auth: String) {
            self.auth = auth
        }
        
        var auth:String
    }
    private static var config:Config?
    internal var config:Config

    public class func setup(_ config:Config){
        PxClient.config = config
    }
    
    private init() {
        guard let newConfig = PxClient.config else {
            fatalError("Error - you must call setup before accessing PxClient.shared")
        }
        config = newConfig
    }
    
    open func fetch(searchTerm:String? = nil,perPage:Int = 80, completion:@escaping (PxResult)->Void) -> PxSearch {
        let search = PxSearch(searchTerm: searchTerm, perPage: perPage, completion: completion)
        search.getNextPage()
        return search
    }
}
