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
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        csvDataUtil = MockCSVHomeViweModel()
        sut = CSVHomeViewModel(csvHomeViewModelUtil: csvDataUtil)
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        csvDataUtil = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testStringData() {
        let strData = emptyString.getStringDataFromUrl(stringURL: sut._baseUrlPath)
        XCTAssertNotNil(strData)
    }
    
    func testConvertDateFormatter() {
        let expectedDate = "02 Jan 1978"
        let givenDateStr = emptyString.convertDateFormat(strDT: "1978-01-02T00:00:00", givenFormat: "yyyy-MM-dd'T'HH:mm:ss", expectedFormat: "dd MMM yyyy")
        XCTAssertEqual(givenDateStr, expectedDate)
    }
    
    func testModelMapping() {
        let objCsv1 = UserModel(dob: "2001-04-20T00:00:00", firstName: "john", lastName: "john", issueCount: 4)
        let objCsv2 = UserModel(dob: "1950-11-12T00:00:00", firstName: "Fiona", lastName: "de Vries", issueCount: 7)
        let csvModel = [objCsv1, objCsv2]
        let csvViewModel = sut.mapUserDataToViewModel(userModel: csvModel)
        XCTAssertNotNil(csvViewModel)
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


//    func getAllValues(stringData: String) -> [UserModel]? {
//        let obj = UserModel(dob: "21st Jan", firstName: "John", lastName: "depp", issueCount: 2)
//        let objVM = [UserDataViewModel(data: obj)]
//        let bb = CSVWithDITests()
//        bb.output.receivedOutputData(userDataViewModel: objVM, error: nil)
//        return [obj]
//    }

}
//
//class MockOutputCSV: OutputDataForCSV {
//
//    var mockVMArray: [UserDataViewModel]?
//
//    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?) {
//        mockVMArray = userDataViewModel
//    }
//}
