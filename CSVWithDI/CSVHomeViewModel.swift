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

protocol GetCSVHomeViewModel: CSVReadUtil {
    func getAllValuesForCSV(stringData: String, completion: @escaping (Result<[UserModel], Error>) -> Void)
}

class CSVHomeDataReadUtil: GetCSVHomeViewModel {
    
    func getAllValuesForCSV(stringData: String, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        var userArray = [UserModel]()
        let rows = getAllRows(stringData: stringData)
        guard let rowsData = rows.first else {
            completion(.failure(NSError()))
            return
        }
        let columnTitles = getAllFields(oldFromString: rowsData)
        let columnArr = columnTitles[0].components(separatedBy: Delimiter.comma.rawValue)
        for i in 0..<rows.count {
            if i != 0 {
                let obj = rows[i].components(separatedBy: Delimiter.comma.rawValue)
                if columnArr.count == obj.count {
                    let ct = Int(obj[2]) ?? 0
                    let firstName = obj[0]
                    let lastName = obj[1]
                    let objCSV = UserModel(dob: emptyString, firstName: firstName, lastName: lastName, issueCount: ct)
                    userArray.append(objCSV)
                }
            }
        }
        completion(.success(userArray))
    }
}

class CSVHomeViewModel {
    
    private let csvHomeViewModelUtil: GetCSVHomeViewModel
    weak var outputData: OutputDataForCSV?
    
    init(csvHomeViewModelUtil: GetCSVHomeViewModel) {
        self.csvHomeViewModelUtil = csvHomeViewModelUtil
    }
    
    func getDataFromCSV() {
        csvHomeViewModelUtil.getAllValuesForCSV(stringData: String) { result in
            switch result {
            case .success(let userModel):
                
                outputData?.receivedOutputData(userDataViewModel: <#T##[UserDataViewModel]?#>, error: <#T##Error?#>)
            case .failure(let error):
                outputData?.receivedOutputData(userDataViewModel: nil, error: error)
            }
        }
        outputData?.receivedOutputData(userDataViewModel: ar, error: nil)
    }
    
    func mapUserDataToViewModel() {
        
    }
    
}
