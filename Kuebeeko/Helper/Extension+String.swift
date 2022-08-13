//
//  Extension+String.swift
//  Kuebeeko
//
//  Created by Hitesh on 12/08/22.
//

import Foundation

extension String {
    
    var intValue:     Int?        { return NumberFormatter().number(from: self)?.intValue    }
    var int8Value:    Int8?       { return NumberFormatter().number(from: self)?.int8Value   }
    var int16Value:   Int16?      { return NumberFormatter().number(from: self)?.int16Value  }
    var int32Value:   Int32?      { return NumberFormatter().number(from: self)?.int32Value  }
    var int64Value:   Int64?      { return NumberFormatter().number(from: self)?.int64Value  }
    var floatValue:   Float?      { return NumberFormatter().number(from: self)?.floatValue  }
    var doubleValue:  Double?     { return NumberFormatter().number(from: self)?.doubleValue }
    var boolValue:    Bool?       { return NumberFormatter().number(from: self)?.boolValue   }
    var decimalValue: Decimal?    { return NumberFormatter().number(from: self)?.decimalValue}
    var binaryValue:  Data?       { return self.data(using: .utf8)                           }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}
