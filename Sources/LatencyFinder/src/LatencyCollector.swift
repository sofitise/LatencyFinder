//
//  LatencyCollector.swift
//  LatencyFinder
//
//  Created by Mohamad Saeedi on 12/11/2024.
//

import Foundation

actor LatencyCollector {
    private var latencies: [Double] = []
    
    func addLatency(_ latency: Double) {
        latencies.append(latency)
    }
    
    func calculateAverage() -> Double? {
        guard !latencies.isEmpty else { return nil }
        return latencies.reduce(0, +) / Double(latencies.count)
    }
}
