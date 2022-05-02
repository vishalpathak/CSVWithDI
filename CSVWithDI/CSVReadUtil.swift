//
//  CSVReadUtil.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import Foundation

protocol CSVReadUtil {
    func getAllRows(stringData:String)-> [String]
    func getAllFields(oldFromString: String) -> [String]
}

extension CSVReadUtil {
    
    func getAllRows(stringData:String)-> [String] {
        var cleanFile = stringData
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile.components(separatedBy: "\n")
    }
    
    func getAllFields(oldFromString: String) -> [String] {
        let delimiter = "\t"
        var newString = oldFromString.replacingOccurrences(of: "\",\"", with: delimiter)
        newString = newString.replacingOccurrences(of: ",\"", with: delimiter)
        newString = newString.replacingOccurrences(of: "\",", with: delimiter)
        newString = newString.replacingOccurrences(of: "\"", with: "")
        return newString.components(separatedBy: delimiter)
    }
    
}
