//
//  DateFormatter+Tools.swift
//  Celo
//
//  Created by Viajeros Lado B on 18/06/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    enum TimeFormat: String {
        case hourMinutes = "HH:mm"
        case dayMonthHourMinutes = "dd MMM HH:mm"
        case fullDescription = "EEEE d MMM yyyy HH:mm"
        case prettyDate = "MMM dd yyyy"
    }
    
    static func unixTimestampToString(unixNumber: Int, secondsFromGMT: Int, format: TimeFormat) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixNumber))

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format.rawValue
        dateFormatterPrint.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        
        return(dateFormatterPrint.string(from: date))
    }
    
    static func fullFormatStringToString(string: String, format: TimeFormat) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format.rawValue
        
        if let date = dateFormatterGet.date(from: string) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
        
    }
}
