//
//  Extensions.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import Foundation

extension String {
    func getStringDataFromUrl(stringURL: URL?) -> String? {
        if let url = stringURL {
            do {
                return try String(contentsOf: url, encoding: .utf8)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
