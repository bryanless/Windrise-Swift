//
//  DateFormat.swift
//  Windrise-Swift
//
//  Created by user on 19/05/22.
//

import Foundation

private let dateFormatterApi = DateFormatter()
private let dateFormmaterBirthday = DateFormatter()
private let DEFAULT_DATE = "2019-09-28"
private let DEFAULT_YEAR = "2000"
private let API_YEAR = "0000"

struct DateFormat {
    static func dateToBirthday(_ birthday: String) -> String {
        dateFormatterApi.dateFormat = "yyyy-MM-dd"
        dateFormmaterBirthday.dateFormat = "dd MMMM"
        
        let birthday = birthday.replacingOccurrences(of: API_YEAR, with: DEFAULT_YEAR)
        
        guard let date = dateFormatterApi.date(from: birthday) else {
            return birthday
        }
        
        let dateString = dateFormmaterBirthday.string(from: date)
        
        return dateString
    }
}
