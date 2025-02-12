//
//  File.swift
//  Calender
//
//  Created by Apple on 12/02/25.
//

import Foundation

class LocalJsonDataManager {
    static let shared = LocalJsonDataManager()
    
    private init() {}
    
    func getData() ->  MonthDetails?{
        guard let url = Bundle.main.url(forResource: "calenderJson", withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let calenderDate = try JSONDecoder().decode(MonthDetails.self, from: data)
            //print(calenderDate)
            return calenderDate
        }catch {
            print("Catch")
        }
        return nil
    }
}
