//
//  CommonUtils.swift
//  CSVWithDI
//
//  Created by C879403 on 03/05/22.
//

import Foundation

final class CommonUtils {
    
    static func convertDateFormater(strDT: String, givenFormat: String, expectedFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        guard let date = dateFormatter.date(from: strDT) else { return nil }
        dateFormatter.dateFormat = expectedFormat
        return  dateFormatter.string(from: date)
    }
}
