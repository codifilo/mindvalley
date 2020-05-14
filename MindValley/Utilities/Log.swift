//
//  Log.swift
//  MindValley
//
//  Copyright © 2020 Agustín Prats.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
