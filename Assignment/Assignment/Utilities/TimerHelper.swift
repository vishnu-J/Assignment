//
//  File.swift
//  Assignment
//
//  Created by Vishnu on 08/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import Foundation

/// SESSION enum used to categorise the current session according to the current time
  /**
    `Morning` from `6 AM to 11.59 `,
    `AfterNoon`  from  `12 PM to  4 PM`
    `Eveninig` from  `4 PM to 7 PM`,
    `Night` from  `7 PM to 10 PM`
    `Invalid` from `10 PM to 6 AM`
  */
enum SESSION:String, Codable{
    case MORNING = "MORNING"
    case AFTERNOON = "AFTERNOON"
    case EVENING = "EVENING"
    case NIGHT = "NIGHT"
    case INVALID = "invalid"
}


/// Meridiem is  to check AM And PM according to the current time
enum Meridiem:String{
    case AM = "AM"
    case PM = "PM"
}

/// TimerHelper is a helper class used to get the current session when the user uses the app .TimerHelper will decide the session according to the  current time. I am considering the time duration only from `6 AM to 10 PM`
class TimerHelper {
    
   // static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var generalFormat = "yyyy-MM-dd hh:mm"
    static var timeFormat = "hh:mm a"
    static var minuteFormat = "mm"
    static var hourFormat = "hh"
    static var meridiemFormat = "a"
    static var monthFormat = "MMM"
    static var dateFormat = "dd"

    

    static var dateFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateFormat = dateFormat
       formatter.locale = Locale.current
       formatter.timeZone = TimeZone.current
       return formatter
    }
    
    static var monthFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateFormat = monthFormat
       formatter.locale = Locale.current
       formatter.timeZone = TimeZone.current
       return formatter
   }
    
    static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    static var generalFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateFormat = generalFormat
       formatter.locale = Locale.current
       formatter.timeZone = TimeZone.current
       return formatter
    }
    
    static var hourFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateFormat = hourFormat
       formatter.locale = Locale.current
       formatter.timeZone = TimeZone.current
       return formatter
    }
    
    static var minuteFormatter: DateFormatter {
       let formatter = DateFormatter()
       formatter.dateFormat = minuteFormat
       formatter.locale = Locale.current
       formatter.timeZone = TimeZone.current
       return formatter
    }
    
    static var meridiemFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateFormat = meridiemFormat
          formatter.locale = Locale.current
          formatter.timeZone = TimeZone.current
          return formatter
    }
    
    
    /// getSession will return the current session according to the current time
    func getSession() -> SESSION{
        
        let hour = Int(Date().toHourString())!
        let _ = Int(Date().toMinuteString())!
        
        if Date().toMeridiemString() == Meridiem.AM.rawValue{
            if hour == 12{
                return SESSION.AFTERNOON
            }else if hour > 6{
                return SESSION.MORNING
            }else{
                return SESSION.INVALID
            }
        }else{
            if hour <= 4 {
                return SESSION.AFTERNOON
            }else if hour > 4 && hour <= 7{
                return SESSION.EVENING
            }else if hour > 7 && hour <= 10{
                return SESSION.NIGHT
            }else{
                return SESSION.INVALID
            }
        }
    }
}

extension Date{
    
    func toHourString() -> String {
        return TimerHelper.hourFormatter.string(from: self as Date)
    }
    
    func toMinuteString() -> String {
        return TimerHelper.minuteFormatter.string(from: self as Date)
    }
    
    func toTimeString() -> String {
        return TimerHelper.timeFormatter.string(from: self as Date)
    }
    
    func toMeridiemString() -> String {
        return TimerHelper.meridiemFormatter.string(from: self as Date)
    }
    
    func toDateString() -> String {
        return TimerHelper.dateFormatter.string(from: self as Date)
    }
    
    func toMonthString() -> String {
        return TimerHelper.monthFormatter.string(from: self as Date)
    }
    
    func toString() -> String {
        return TimerHelper.generalFormatter.string(from: self as Date)
    }
    
}
