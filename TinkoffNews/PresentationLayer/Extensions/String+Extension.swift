//
//  String+Extension.swift
//  TinkoffNews
//
//  Created by Илья Варфоломеев on 30.06.2018.
//  Copyright © 2018 Илья Варфоломеев. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        
        do {
            let fontAttributes: [NSAttributedStringKey : Any] = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .body), NSAttributedStringKey.foregroundColor: UIColor.white]
            let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue]
            
            let mutableAttrString = try NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
            mutableAttrString.addAttributes(fontAttributes, range: mutableAttrString.mutableString.range(of: mutableAttrString.mutableString as String))
            
            return mutableAttrString
        } catch{
            return NSAttributedString()
        }
    }
    
    func getReadableDateString() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        let formattedDate = formatter.date(from: self)
        formatter.dateFormat = "d MMMM, HH:mm"
        
        if let formattedDateUnwrapped = formattedDate {
            return formatter.string(from: formattedDateUnwrapped)
        }
        
        return self
    }
}
