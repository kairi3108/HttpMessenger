//
//  ResponseDeserializer.swift
//  HttpMessenger
//
//  Created by Yuto on 2020/12/17.
//

import Foundation

protocol ResponseDeserializer {
    func decode(_ data:Data?) throws -> Any?
}

class JSONDeserializer: ResponseDeserializer {
    
    let readingOptions: JSONSerialization.ReadingOptions
    
    init(_ readingOptions: JSONSerialization.ReadingOptions = .allowFragments) {
        self.readingOptions = readingOptions
    }
    
    func decode(_ data: Data?) throws -> Any? {
        if let data = data {
            return try JSONSerialization.jsonObject(with: data, options: readingOptions)
        } else {
            return nil
        }
    }
}

class StringDeserializer: ResponseDeserializer {
    
    let stringEncoding: String.Encoding
    
    init(_ encoding: String.Encoding = .utf8) {
        stringEncoding = encoding
    }
    
    func decode(_ data: Data?) throws -> Any? {
        if let data = data {
            return String.init(data: data, encoding: stringEncoding)
        } else {
            return nil
        }
    }
}

class DataDeserializer: ResponseDeserializer {
    func decode(_ data: Data?) throws -> Any? {
        return data
    }
}
