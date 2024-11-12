// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@objc public protocol LatencyFinderType {
    
    /// Find latency for a host, pings host just once
    /// - Parameters:
    /// - host: host for which the latency should be found
    /// - completion: closure that is called with the latency result in millinseconds - will return nil if request fails
    //@objc func findLatency(for host: String, completion: @escaping @Sendable (NSNumber?) -> Void)
    
    
    /// Returns average latency for a host
    /// - Parameters:
    /// - host: host for which the latency should be found
    /// - repeatCount: number of Head requests to send in order to calculate average latency
    /// - completion: closure that is called with the latency result in millinseconds - will return nil if request fails
    @objc func findAverageLatency(for host: String, repeatCount: Int, completion: @escaping @Sendable (NSNumber?) -> Void)
}

@objc public class LatencyFinder: NSObject, LatencyFinderType {
    
    func findLatency(for host: String, completion: @escaping @Sendable (NSNumber?) -> Void) {
        
        guard let url = URL(string: host) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        
        let startTime = Date()
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            var latency: NSNumber? = nil
            if error == nil && response != nil {
                let interval = Date().timeIntervalSince(startTime) * 1000
                latency = NSNumber(value: interval)
            }
            
            DispatchQueue.main.async {
                completion(latency)
            }
        }
        
        dataTask.resume()
    }
    
    @objc public func findAverageLatency(for host: String, repeatCount: Int, completion: @escaping @Sendable (NSNumber?) -> Void) {
        let dispatchGroup = DispatchGroup()
        let latencyCollector = LatencyCollector()
        
        for _ in 1...repeatCount {
            dispatchGroup.enter()
            findLatency(for: host) { latency in
                if let latencyValue = latency?.doubleValue {
                    Task {
                        await latencyCollector.addLatency(latencyValue)
                    }
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            Task {
                let averageLatency = await latencyCollector.calculateAverage()
                guard let averageLatency else {
                    completion(nil)
                    return
                }
                completion(NSNumber(value: averageLatency))
            }
        }
    }
}
