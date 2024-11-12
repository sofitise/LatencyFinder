// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@objc public protocol LatencyFinderType {
    
    /// Find latency for a host, pings host just once
    /// - Parameters:
    /// - host: host for which the latency should be found
    /// - completion: closure that is called with the latency result in millinseconds - will return nil if request fails
    @objc func findLatency(for host: String, completion: @escaping (NSNumber?) -> Void)
    
    
    /// Returns average latency for a host
    /// - Parameters:
    /// - host: host for which the latency should be found
    /// - repeatCount: number of Head requests to send in order to calculate average latency
    /// - completion: closure that is called with the latency result in millinseconds - will return nil if request fails
    @objc func findAverageLatency(for host: String, repeatCount: Int, completion: @escaping (NSNumber?) -> Void)
}
