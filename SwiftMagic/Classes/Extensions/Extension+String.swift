//
//  LoggerViewController.swift
//  SwiftMagic
//
//  Created by Zhihui Tang on 2018-01-10.
//


import Foundation

extension String {


    ///
    func substring(to index: Int) -> String {
        guard let end_Index = validEndIndex(original: index) else {
            return self
        }
        return String(self[startIndex..<end_Index])
    }
    ///
    func substring(from index: Int) -> String {
        guard let start_index = validStartIndex(original: index)  else {
            return self
        }
        return String(self[start_index..<endIndex])
    }
    ///
    func sliceString(_ range: CountableRange<Int>) -> String {
        guard
            let startIndex = validStartIndex(original: range.lowerBound),
            let endIndex   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        return String(self[startIndex..<endIndex])
    }
    ///
    func sliceString(_ range: CountableClosedRange<Int>) -> String {
        guard
            let start_Index = validStartIndex(original: range.lowerBound),
            let end_Index   = validEndIndex(original: range.upperBound),
            startIndex <= endIndex
            else {
                return ""
        }
        if endIndex.encodedOffset <= end_Index.encodedOffset {
            return String(self[start_Index..<endIndex])
        }
        return String(self[start_Index...end_Index])
    }
    
    private func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.encodedOffset : return startIndex
        case endIndex.encodedOffset...   : return endIndex
        default                          : return index(startIndex, offsetBy: original)
        }
    }
    
    private func validStartIndex(original: Int) -> String.Index? {
        guard original <= endIndex.encodedOffset else { return nil }
        return validIndex(original: original)
    }
    
    private func validEndIndex(original: Int) -> String.Index? {
        guard original >= startIndex.encodedOffset else { return nil }
        return validIndex(original: original)
    }

    ///
    func toDate(formatter: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = formatter
        let date = dateFormatter.date(from: self)
        return date!
    }
    
}
