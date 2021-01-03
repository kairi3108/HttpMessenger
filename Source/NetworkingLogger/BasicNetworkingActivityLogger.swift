//
//  BasicNetworkingActivityLogger.swift
//  HttpMessenger
//
//  Created by Yuto on 2020/12/21.
//

import Foundation

class BasicNetworkingActivityLogger: HttpMessengerLogger {
    
    init(_ logLevel: LogLevel = .debug) {
        let logDetail = LogDetail(logLevel, dateFormatter: nil, date: true, level: true, fileInfo: true, funcNmae: true)
        super.init(logDetail)
    }
    
    override func output(_ formated: String) {
        print(formated)
    }
}

class SystemNetworkingActivityLogger: HttpMessengerLogger {
    
    init(_ logLevel: LogLevel = .debug) {
        let logDetail = LogDetail(logLevel, dateFormatter: nil, date: false, level: true, fileInfo: true, funcNmae: true)
        super.init(logDetail)
    }
    
    override func output(_ formated: String) {
        NSLog(formated)
    }
}
