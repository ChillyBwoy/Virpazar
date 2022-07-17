//
//  DateSequenceSpec.swift
//  VirpazarTests
//
//  Created by Eugene Cheltsov on 17.07.2022.
//

import XCTest

class DateSequenceSpec: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let date = Calendar.current.date(from: DateComponents(year: 2022, month: 7, day: 17, hour: 14, minute: 0, second: 0))!

        let seq = DateSequence(startDate: date, times: 3)
        
        var arr = [Date]()
        
        for d in seq {
            arr.append(d)
        }
        debugPrint("__arr:", arr)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
