//
//  CSVHomeViewModelTests.swift
//  CSVWithDITests
//
//  Created by C879403 on 03/05/22.
//

import XCTest
@testable import CSVWithDI

class CSVHomeViewModelTests: XCTestCase {

    private var sut: CSVHomeViewModel!
    private var csvHomeViewModelUtil: MockCSVHomeViewModelUtil!
    private var outputCsvMock: MockCSVModelOutput!
    
    
    override func setUpWithError() throws {
        outputCsvMock = MockCSVModelOutput()
        csvHomeViewModelUtil = MockCSVHomeViewModelUtil()
        sut = CSVHomeViewModel(csvHomeViewModelUtil: csvHomeViewModelUtil)
        sut.outputData = outputCsvMock
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        outputCsvMock = nil
        csvHomeViewModelUtil = nil
        sut = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCSVReadData() {
        //given
        let userModel = [UserModel(dob: "1978-01-02T00:00:00", firstName: "Fiona", lastName: "Vrij", issueCount: 2)]
        csvHomeViewModelUtil.mockCSVResult = .success(userModel)
        
        //when
        sut.getDataFromCSV()
        
        //then
        XCTAssertEqual(outputCsvMock.userVM.count, 1)
        XCTAssertEqual(outputCsvMock.userVM[0].fullName, "Fiona Vrij")
    }
    
    func testCSVReadFailData() {
        //given
        csvHomeViewModelUtil.mockCSVResult = .failure(NSError(domain: "Error in Data", code: 10, userInfo: nil))
        
        //when
        sut.getDataFromCSV()
        
        //then
        XCTAssertEqual(outputCsvMock.errorVM.localizedDescription, "The operation couldn’t be completed. (Error in Data error 10.)")
    }

}

class MockCSVHomeViewModelUtil: GetCSVHomeViewModel {
    var mockCSVResult: Result<[UserModel], Error>?
    
    func getAllValuesForCSV(stringData: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        if let mock = mockCSVResult {
            completion(mock)
        }
    }
}

class MockCSVModelOutput: OutputDataForCSV {
    var userVM: [UserDataViewModel] = []
    var errorVM: Error = NSError()
    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?) {
        if let userDataViewModel = userDataViewModel {
            userVM = userDataViewModel
        } else {
            errorVM = error!
        }
    }
}
