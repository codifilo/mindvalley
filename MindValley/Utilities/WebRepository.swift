//
//  WebRepository.swift
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
import Combine

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var bgQueue: DispatchQueue { get }
    var fileCache: FileCache { get }
}

extension WebRepository {
    func call<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success)
        -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.urlRequest(baseURL: baseURL)
            return receiveAndParse(request, with: httpCodes)
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
    
    func cachedCall<Value>(endpoint: APICall, httpCodes: HTTPCodes = .success)
        -> AnyPublisher<Value?, Error> where Value: Decodable {
            
            Publishers.CombineLatest(
                cached(key: endpoint.absoluteUrl(from: baseURL).sha256()),
                Publishers.Merge(Just(nil).mapError({ $0 as Error }),
                                 call(endpoint: endpoint, httpCodes: httpCodes))
            ).map { cached, value in value ?? cached }
            .eraseToAnyPublisher()
    }
    
    private func receiveAndParse<Value>(_ request: URLRequest,
                                        with httpCodes: HTTPCodes = .success)
        -> AnyPublisher<Value, Error> where Value: Decodable {
            
            session
                .dataTaskPublisher(for: request)
                .requestJSON(httpCodes: httpCodes, cache: fileCache)
    }
    
    private func cached<Value>(key: String)
        -> AnyPublisher<Value?, Error> where Value: Decodable {
            
        Future<Data?, Error> { completion in
            DispatchQueue.global().async {
                do {
                    let data = try self.fileCache.read(key: key)
                    completion(.success(data))
                } catch {
                    completion(.success(nil))
                }
            }
        }.flatMap { data -> AnyPublisher<Value?, Error> in
            if let data = data {
                return Just(data)
                    .decode(type: Value.self, decoder: JSONDecoder())
                    .map { value -> Value? in .some(value) }
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            } else {
                return Just(nil)
                    .mapError { $0 as Error }
                    .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}

// MARK: - Helpers

private extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestJSON<Value>(httpCodes: HTTPCodes, cache: FileCache? = nil)
        -> AnyPublisher<Value, Error> where Value: Decodable {
            
        return tryMap { data, response in
                assert(!Thread.isMainThread)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unexpectedResponse
                }
                guard httpCodes.contains(httpResponse.statusCode) else {
                    throw APIError.httpCode(httpResponse.statusCode)
                }
                if let cache = cache, let url = httpResponse.url?.absoluteString {
                    cache.save(data: data, key: url.sha256())
                }
                return data
            }
            .extractUnderlyingError()
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension Publisher {
    
    /// Holds the downstream delivery of output until the specified time interval passed after the subscription
    /// Does not hold the output if it arrives later than the time threshold
    ///
    /// - Parameters:
    ///   - interval: The minimum time interval that should elapse after the subscription.
    /// - Returns: A publisher that optionally delays delivery of elements to the downstream receiver.
    
    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}
