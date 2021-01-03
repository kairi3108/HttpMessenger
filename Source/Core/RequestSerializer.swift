//
//  RequestSerializer.swift
//  HttpMessenger
//
//  Created by Yuto on 2020/12/17.
//

import Foundation

protocol RequestSerializer {
    var contentType: String? { get }
    init(contentType: String?)
    
    func encode(_ data:Any?) -> Data?
}

protocol QueryRequestSerializer: RequestSerializer {
    func encode(_ data: Any?) -> [URLQueryItem]?
}

class DataSerializer: RequestSerializer {
    let contentType: String?
    
    required init(contentType: String? = nil) {
        self.contentType = contentType
    }
    
    func encode(_ data: Any?) -> Data? {
        if data != nil, let data = data, data is Data {
            return data as? Data
        } else {
            return nil
        }
    }
}

class StringSerializer: RequestSerializer {
    let contentType: String?
    
    required init(contentType: String? = "text/plain") {
        self.contentType = contentType
    }
    
    func encode(_ data: Any?) -> Data? {
        if data != nil, let data = data, data is Data {
            return data as? Data
        } else {
            return nil
        }
    }
}

class JSONSerializer: RequestSerializer {
    let contentType: String?
    let wirtingOptions: JSONSerialization.WritingOptions
    
    required convenience init(contentType: String? = "application/json") {
        self.init(contentType: contentType, options: .fragmentsAllowed)
    }
    
    init(contentType: String? = "application/json", options: JSONSerialization.WritingOptions = .fragmentsAllowed) {
        self.contentType = contentType
        self.wirtingOptions = options
    }
    
    func encode(_ data: Any?) -> Data? {
        if let data = data {
            return try! JSONSerialization.data(withJSONObject: data, options: wirtingOptions)
        } else {
            return nil
        }
    }
}

class URLQueryRequestSerialiser: QueryRequestSerializer {
    let contentType: String?
    
    required init(contentType: String? = "application/x-www-form-urlencoded") {
        self.contentType = contentType
    }
    
    func encode(_ data: Any?) -> Data? {
        return nil
    }
    
    func encode(_ data: Any?) -> [URLQueryItem]? {
        var ret: [URLQueryItem]? = nil
        if data is [String : String], let data = data as? [String : String] {
            ret = []
            for d in data {
                ret?.append(URLQueryItem(name: d.0, value: d.1))
            }
        }
        return ret
    }
}
