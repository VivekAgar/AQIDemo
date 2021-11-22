//
//  AQIDBHelper.swift
//  aqi
//
//  Created by vivek on 21/11/21.
//

import Foundation
import SQLite3

class AQIDBHelper{
    
    //record id, city , AQI value,
    //create db
    var db : OpaquePointer?
    var path : String = "myDataBaseName.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(filePath)")
            return db
        }
    }
    
    //create table
    
    func createTable()  {
        let query = "CREATE TABLE IF NOT EXISTS city_aqi_data(id INTEGER PRIMARY KEY AUTOINCREMENT,city TEXT, aqiValue TEXT, timestamp REAL);"
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Table creation success")
            }else {
                print("Table creation fail")
            }
        } else {
            print("Prepration fail")
        }
    }
    //write data one single record
    func insert(city : String, aqiValue : String, recDate : Date) {
        let query = "INSERT INTO city_aqi_data (id, city, aqiValue, timestamp) VALUES (?, ?, ?, ?);"
        
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            sqlite3_bind_text(statement, 2, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (aqiValue as NSString).utf8String, -1, nil)
            sqlite3_bind_double(statement, 4, recDate.timeIntervalSinceReferenceDate)
            
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Data inserted success")
            }else {
                print("Data is not inserted in table")
            }
        } else {
            print("Query is not as per requirement")
        }
    }
    
    //Write data in array , multiple records in one go Improves performance drastically
    func writeBatchInDb(records: [AQIRecord]){
            let querypart1 = "INSERT INTO city_aqi_data (city, aqiValue, timestamp) VALUES "
            var queryPart2 = ""
            for element in records{
                queryPart2 += "( '" + element.city!.utf8DecodedString()
                queryPart2 += "' , \(element.aqi!)"
                queryPart2 += ",\(element.timestamp!.timeIntervalSinceReferenceDate) ),"
            }
        var query = querypart1 + queryPart2.dropLast() + ";"
        print(" query =  \(query)")
        
            var statement : OpaquePointer? = nil
            if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
        
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Data inserted success")
                }else {
                    print("Data is not inserted in table")
                }
            } else {
                print("Query is not as per requirement")
            }
    }
    //Read data from db All latest records within given time duration in second (ex Half hour(30 * 60) or 1 Hour(60 *60))
    func readHistoricalDataFor(city: String, seconds: Int) -> [AQIRecord]?{
        var mainList = [AQIRecord]()
        let today = Date()
        print(today)
        let modifiedDate = Calendar.current.date(byAdding: .second, value: -seconds, to: today)!
        print(modifiedDate)
        let query = "SELECT * FROM city_aqi_data WHERE city = \'\(city)\' AND timestamp <= \(modifiedDate.timeIntervalSinceReferenceDate);"
        print("Read Query \(query)")
        //SELECT * FROM city_aqi_data WHERE city = 'Indore' AND timestamp <= 659280000.314894;
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = Int(sqlite3_column_int(statement, 0))
                let cityName = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                let aqivalue = Double(String(cString: sqlite3_column_text(statement, 2))) ?? 0.00
                let timest = Double(String(cString: sqlite3_column_text(statement, 3))) ?? 0.00
                let model = AQIRecord(city: cityName, aqi: aqivalue, timestamp: Date(timeIntervalSinceReferenceDate: timest))
                model.timestamp = Date(timeIntervalSinceReferenceDate: timest)
                mainList.append(model)
            }
          return mainList
      }
      else{
        return nil
      }
    }
    //read latest data for city
    //read historical data for City for last 24 hour
    //read historical data for City for last 1 week
    //read historical data for City for last 1 month
    
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
