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
        self.fullName = "\(data.firstName ?? "NA") \(data.lastName ?? "NA")"
        self.dob = data.dob?.convertDateFormat(strDT: data.dob, givenFormat: "yyyy-MM-dd'T'HH:mm:ss", expectedFormat: "dd MMM yyyy")
        self.issueCount = "\(data.issueCount ?? 0)"
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
            completion(.failure(NSError(domain: "Error in Data", code: 10, userInfo: nil)))
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
                    let dob = obj[3]
                    let objCSV = UserModel(dob: dob, firstName: firstName, lastName: lastName, issueCount: ct)
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
    private let baseUrlPath: URL? = {
        if let path = Bundle.main.url(forResource: "issues", withExtension: FileExtesions.csv.rawValue) {
            return path
        } else {
            return nil
        }
    }()
    
    init(csvHomeViewModelUtil: GetCSVHomeViewModel) {
        self.csvHomeViewModelUtil = csvHomeViewModelUtil
    }
    
    func getDataFromCSV() {
        
        guard let stringData = emptyString.getStringDataFromUrl(stringURL: baseUrlPath) else { return }
        
        csvHomeViewModelUtil.getAllValuesForCSV(stringData: stringData) { [weak self] res in
            switch res {
            case .success(let userModel):
                let userVM = self?.mapUserDataToViewModel(userModel: userModel)
                self?.outputData?.receivedOutputData(userDataViewModel: userVM, error: nil)
            case .failure(let error):
                self?.outputData?.receivedOutputData(userDataViewModel: nil, error: error)
            }
        }
    }
    
    func mapUserDataToViewModel(userModel: [UserModel]?) -> [UserDataViewModel]? {
        if let userModel = userModel {
            let modelArray = userModel.map { (obj: UserModel) -> UserDataViewModel in
                return UserDataViewModel(data: obj)
            }
            return modelArray
        } else {
            return nil
        }
    }
}
