//
// ServiceManager.swift
// iTunesBasic
//
// Created on 18.02.2022.
// Oguzhan Yalcin
//
//
//


import Foundation
import Alamofire

class ServiceManager {
    
    static let shared = ServiceManager()
    
    let baseUrl:String = "https://itunes.apple.com/"
    
    typealias tokenHandler = (_ request:URLRequest?, Bool) -> Void
    
    
    func getStoreItems(term:String, country:String, limit:Int, handler: @escaping (([StoreResponse]?, Bool) -> Void)) {
        
        let errorCode = "1000"
        
        let headers = ["Content-Type":"application/json", "Accept": "application/json"]
        let httpHeaders = HTTPHeaders(headers)
        
        let url = baseUrl + "search?term=\(term)&country=\(country)&limit=\(limit)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: httpHeaders).responseData(completionHandler: { (response) in
            guard let data = response.data else {
                print("\(errorCode) Network Error")
                handler(nil, false)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                //let json = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                print("\(String(describing: json))")
                
                let theResponse = try JSONDecoder().decode(StoreCheckResponse.self, from: data)
                
                guard (theResponse.results?.count ?? 0) > 0 else {
                    print("\(errorCode) Response Error")
                    handler(nil, false)
                    return
                }
                
                handler(theResponse.results, true)
            }
            catch {
                print("\(errorCode) Decoder Error")
                handler(nil, false)
            }
        })
    }
}
