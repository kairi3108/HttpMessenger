//
//  ResponseDeserializer.swift
//  HttpMessenger
//
//  Created by Yuto on 2020/12/17.
//

import Foundation

public protocol ResponseDeserializer {
    func decode(_ data:Data?) throws -> Any?
}

public class JSONDeserializer: ResponseDeserializer {
    
    let readingOptions: JSONSerialization.ReadingOptions
    
    public init(_ readingOptions: JSONSerialization.ReadingOptions = .allowFragments) {
        self.readingOptions = readingOptions
    }
    
    public func decode(_ data: Data?) throws -> Any? {
        if let data = data {
            return try JSONSerialization.jsonObject(with: data, options: readingOptions)
        } else {
            return nil
        }
    }
}

public class StringDeserializer: ResponseDeserializer {
    
    let stringEncoding: String.Encoding
    
    public init(_ encoding: String.Encoding = .utf8) {
        stringEncoding = encoding
    }
    
    public func decode(_ data: Data?) throws -> Any? {
        if let data = data {
            return String.init(data: data, encoding: stringEncoding)
        } else {
            return nil
        }
    }
}

public class DataDeserializer: ResponseDeserializer {
    public func decode(_ data: Data?) throws -> Any? {
        return data
    }
}
