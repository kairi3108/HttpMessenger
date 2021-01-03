//
//  RequestSerializer.swift
//  HttpMessenger
//
//  Created by Yuto on 2020/12/17.
//

import Foundation

public protocol RequestSerializer {
    var contentType: String? { get }
    init(contentType: String?)
    
    func encode(_ data:Any?) -> Data?
}

public protocol QueryRequestSerializer: RequestSerializer {
    func encode(_ data: Any?) -> [URLQueryItem]?
}

public class DataSerializer: RequestSerializer {
    public let contentType: String?
    
    required public init(contentType: String? = nil) {
        self.contentType = contentType
    }
    
    public func encode(_ data: Any?) -> Data? {
        if data != nil, let data = data, data is Data {
            return data as? Data
        } else {
            return nil
        }
    }
}

public class StringSerializer: RequestSerializer {
    public let contentType: String?
    
    required public init(contentType: String? = "text/plain") {
        self.contentType = contentType
    }
    
    public func encode(_ data: Any?) -> Data? {
        if data != nil, let data = data, data is Data {
            return data as? Data
        } else {
            return nil
        }
    }
}

public class JSONSerializer: RequestSerializer {
    public let contentType: String?
    let wirtingOptions: JSONSerialization.WritingOptions
    
    required public convenience init(contentType: String? = "application/json") {
        self.init(contentType: contentType, options: .fragmentsAllowed)
    }
    
    init(contentType: String? = "application/json", options: JSONSerialization.WritingOptions = .fragmentsAllowed) {
        self.contentType = contentType
        self.wirtingOptions = options
    }
    
    public func encode(_ data: Any?) -> Data? {
        if let data = data {
            return try! JSONSerialization.data(withJSONObject: data, options: wirtingOptions)
        } else {
            return nil
        }
    }
}

public class URLQueryRequestSerialiser: QueryRequestSerializer {
    public let contentType: String?
    
    required public init(contentType: String? = "application/x-www-form-urlencoded") {
        self.contentType = contentType
    }
    
    public func encode(_ data: Any?) -> Data? {
        return nil
    }
    
    public func encode(_ data: Any?) -> [URLQueryItem]? {
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
