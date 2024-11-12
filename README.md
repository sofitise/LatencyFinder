# LatencyFinder Framework

[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Swift Version](https://img.shields.io/badge/swift-5.5%2B-orange)](https://swift.org)

A Swift framework to measure network latency by sending HTTP `HEAD` requests to a specified host. The framework can be used to measure latency for a single request or calculate an average latency over multiple requests.

## Features

- Measure the latency for a single `HEAD` request.
- Calculate the average latency across multiple `HEAD` requests.
- Supports both Swift and Objective-C projects.

## Requirements

- iOS 15.0+
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager (Recommended)

1. In Xcode, select **File > Add Packages**.
2. Enter the repository URL.
3. Select the latest version and add it to your project.

## Usage

### Swift

#### Measure Latency for a Single Request

```swift
import LatencyFinder

LatencyFinder.findLatency(for: "https://google.com") { latency in
    if let latency = latency {
        print("Single latency: \(latency) ms")
    } else {
        print("Failed to measure latency.")
    }
}
```

#### Measure Average Latency

```
import LatencyFinder

LatencyFinder.findAverageLatency(for: "https://google.com", repeatCount: 5) { averageLatency in
    if let averageLatency = averageLatency {
        print("Average latency: \(averageLatency) ms")
    } else {
        print("Failed to calculate average latency.")
    }
}
```

### Objective-C

#### Measure Average Latency for a host

```swift
#import <LatencyFinder/LatencyFinder.h>

[LatencyFinder findAverageLatencyFor:@"https://google.com" repeatCount:5 completion:^(NSNumber * _Nullable averageLatency) {
    if (averageLatency) {
        NSLog(@"Average latency: %@ ms", averageLatency);
    } else {
        NSLog(@"Failed to calculate average latency.");
    }
}];
```
