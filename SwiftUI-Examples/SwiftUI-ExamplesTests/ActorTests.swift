// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest

final class Counter {
    var value = 0
    
    func increment() -> Int {
        value += 1
        return value
    }
}

class CounterTests: XCTestCase {
    let counter = Counter()
    
    // Creates a data race
    func testConcurrentAccess() {
        Task.detached {
            print(self.counter.increment())
        }
        Task.detached {
            print(self.counter.increment())
        }
        Task.detached {
            print(self.counter.increment())
        }
        Task.detached {
            print(self.counter.increment())
        }
    }
}


actor CountActor {
    var value = 0
    
    func increment() -> Int {
        value += 1
        return value
    }
}

final class CounterTests2: XCTestCase {
    let countActor = CountActor()
    
    func testActor() {
        Task.detached {
            print(await self.countActor.increment())
        }
        Task.detached {
            print(await self.countActor.increment())
        }
        Task.detached {
            print(await self.countActor.increment())
        }
        Task.detached {
            print(await self.countActor.increment())
        }
    }
}
