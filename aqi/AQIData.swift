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
    var aqiValue: Float16?
}



