import XCTest
@testable import LatencyFinder

final class LatencyFinderTests: XCTestCase {
    
    var latencyFinder: LatencyFinderType!
    
    override func setUp() {
        latencyFinder = LatencyFinder()
    }
    
    /// Test measuring latency for a valid host
    func testMeasureLatencyForValidHost() {
        let expectation = XCTestExpectation(description: "Measure latency for a valid host")
        
        latencyFinder.findLatency(for: "https://google.com") { latency in
            XCTAssertNotNil(latency, "Latency should not be nil for a valid host")
            XCTAssertGreaterThan(latency!.doubleValue, 0, "Latency should be greater than zero")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test measuring latency for an invalid host
    func testMeasureLatencyForInvalidHost() {
        let expectation = XCTestExpectation(description: "Measure latency for an invalid host")
        
        latencyFinder.findLatency(for: "invalid.host.example") { latency in
            XCTAssertNil(latency, "Latency should be nil for an invalid host")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test calculating average latency with multiple requests to a valid host
    func testAverageLatencyForValidHost() {
        let expectation = XCTestExpectation(description: "Calculate average latency for a valid host with multiple requests")
        
        latencyFinder.findAverageLatency(for: "https://google.com", repeatCount: 5) { averageLatency in
            XCTAssertNotNil(averageLatency, "Average latency should not be nil for a valid host")
            XCTAssertGreaterThan(averageLatency!.doubleValue, 0, "Average latency should be greater than zero")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test calculating average latency with multiple requests to an invalid host
    func testAverageLatencyForInvalidHost() {
        let expectation = XCTestExpectation(description: "Calculate average latency for an invalid host with multiple requests")
        
        latencyFinder.findAverageLatency(for: "invalid.host.example", repeatCount: 5) { averageLatency in
            XCTAssertNil(averageLatency, "Average latency should be nil for an invalid host")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test calculating average latency with zero requests
    func testAverageLatencyWithZeroRequests() {
        let expectation = XCTestExpectation(description: "Calculate average latency with zero requests")
        
        latencyFinder.findAverageLatency(for: "https://google.com", repeatCount: 0) { averageLatency in
            XCTAssertNil(averageLatency, "Average latency should be nil if count is zero")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test calculating average latency with one request to a valid host
    func testAverageLatencyWithOneRequest() {
        let expectation = XCTestExpectation(description: "Calculate average latency with one request to a valid host")
        
        latencyFinder.findAverageLatency(for: "https://google.com", repeatCount: 1) { averageLatency in
            XCTAssertNotNil(averageLatency, "Average latency should not be nil for one valid request")
            XCTAssertGreaterThan(averageLatency!.doubleValue, 0, "Average latency should be greater than zero")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
}
