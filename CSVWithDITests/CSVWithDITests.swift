//
//  CSVWithDITests.swift
//  CSVWithDITests
//
//  Created by C879403 on 29/04/22.
//

import XCTest
@testable import CSVWithDI

class CSVWithDITests: XCTestCase {
    
    var sut: CSVHomeViewModel!
    var csvDataUtil: MockCSVHomeViweModel!
    var output: MockOutputCSV!
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        output = MockOutputCSV()
        csvDataUtil = MockCSVHomeViweModel()
        sut = CSVHomeViewModel(csvHomeViewModelUtil: csvDataUtil)
        sut.outputData = output
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        csvDataUtil = nil
        output = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCSVHomeViewModel() {
        let _ = csvDataUtil.getAllValues(stringData: "")
        sut.getDataFromCSV()
        XCTAssertEqual(output.mockVMArray?.count, 1)
    }
    
    func testCSVUserData() {
//        let obj = csvDataUtil.getAllValues(stringData: "")
//        //let objVM = UserDataViewModel(data: obj![0])
//        sut.getDataFromCSV()
//        let outputObj = csvDataUtil.
//        XCTAssertEqual(sut.outputData, output.mockVMArray![0].issueCount)
        
    }
}

class MockCSVHomeViweModel: GetCSVHomeViewModel {
    
    func getAllValuesForCSV(stringData: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        
    }
    
    
    func getAllValues(stringData: String) -> [UserModel]? {
        let obj = UserModel(dob: "21st Jan", firstName: "John", lastName: "depp", issueCount: 2)
        let objVM = [UserDataViewModel(data: obj)]
        let bb = CSVWithDITests()
        bb.output.receivedOutputData(userDataViewModel: objVM, error: nil)
        return [obj]
    }
    
}

class MockOutputCSV: OutputDataForCSV {
    
    var mockVMArray: [UserDataViewModel]?
    
    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?) {
        mockVMArray = userDataViewModel
    }
}
