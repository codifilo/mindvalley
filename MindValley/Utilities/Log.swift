//
//  Log.swift
//  HeartPeace
//
//  Created by Agustín Prats Hernandez on 25/10/2019.
//  Copyright © 2019 Agustín Prats. All rights reserved.
//

import Foundation

final class Log {
    
    private enum Level: String {
        case debug = "D"
        case error = "E"
    }
    
    private static var dateFormatter = { () -> DateFormatter in
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }()
    
    private static var now: String {
        return dateFormatter.string(from: Date())
    }
    
    static func d(_ msg: String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        #if DEBUG
        print(format(.debug, msg, fileName, lineNumber))
        #endif
    }
    
    static func e(_ msg: String, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        print(format(.error, msg, fileName, lineNumber))
    }
    
    static func e(_ error: Error, functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line, userInfo: [String: Any] = [:]) {
        print(format(.error, error.localizedDescription, fileName, lineNumber))
    }
    
    private static func format(_ level: Level, _ msg: String, _ fileName: StaticString, _ lineNumber: Int) -> String {
        return "\(now)|\(level.rawValue)|\(String(fileName).lastPathComponent.withoutExtension):\(lineNumber)|\(msg)"
    }
    
    public static func `do`(_ block: (() throws -> Void),
                            functionName: StaticString = #function,
                            fileName: StaticString = #file,
                            lineNumber: Int = #line,
                            userInfo: [String: Any] = [:]) {
        do {
            try block()
        } catch {
            Log.e(error, functionName: functionName,
                  fileName: fileName,
                  lineNumber: lineNumber,
                  userInfo: userInfo)
        }
    }
}


private extension String {
    var withoutExtension: String {
        guard let index = self.lastIndex(of: ".") else { return self }
        return String(prefix(upTo: index))
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    init(_ staticString: StaticString) {
        self = staticString.withUTF8Buffer {
            String(decoding: $0, as: UTF8.self)
        }
    }
}
