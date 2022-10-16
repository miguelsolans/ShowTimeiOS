//
//  Date.swift
//  ShowTime
//
//  Created by Miguel Solans on 16/10/2022.
//

import Foundation


extension Date {
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter();
        dateFormatter.dateFormat = "yyyy-MM-dd";
        
        return dateFormatter.string(from: self);
    }
    
}
