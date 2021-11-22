//
//  AQIDataEntity.swift
//  aqi
//
//  Created by vivek on 20/11/21.
//

import Foundation


class AQIDataList: Codable{
    
    var aqiDataList: [AQIData]?
}

class AQIData: Codable {
    var city: String?
    var aqi: Double?
}


//represent a record in db. helpful for storing latest data for all cities
class AQIRecord{
    
    var city: String?
    var aqi: Double?
    var timestamp: Date?
    
    init(city:String, aqi:Double, timestamp:Date) {
        self.city = city
        self.aqi = aqi
        self.timestamp = timestamp
    }
    
    
}
