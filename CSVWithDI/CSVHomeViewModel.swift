//
//  CSVHomeViewModel.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import Foundation

struct UserModel {
    let dob: String?
    let firstName: String?
    let lastName: String?
    let issueCount: Int?
}

struct UserDataViewModel {
    let fullName: String?
    let dob: String?
    let issueCount: String?
    
    init(data: UserModel) {
        self.fullName = "\(data.firstName!) \(data.lastName!)"
        self.dob = "\(data.dob!)"
        self.issueCount = "\(data.issueCount!)"
    }
}

protocol OutputDataForCSV: AnyObject {
    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?)
}

class CSVHomeViewModel {
    
    private let csvHomeViewModelUtil: CSVHomeViewModelUtil
    weak var outputData: OutputDataForCSV?
    
    init(csvHomeViewModelUtil: CSVHomeViewModelUtil) {
        self.csvHomeViewModelUtil = csvHomeViewModelUtil
    }
    
    func getDataFromCSV() {
        print("ARR VM -> \(["1", "2"])")
    }
    
}
