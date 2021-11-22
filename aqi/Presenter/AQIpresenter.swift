//
//  AQIpresenter.swift
//  aqi
//
//  Created by vivek on 20/11/21.
//

import Foundation

protocol AQIPresenterProtocol{
    
    var view: AQIView? {get set}
    var interactor: AQIInteractor? {get set}
    var router: AQIRouter? {get set}
    func interactorDidfetchedData(With result: Result<Any, Error > )
    
}


class AQIPresenter: AQIPresenterProtocol{
    weak var view: AQIView?
    var interactor: AQIInteractor? {
        didSet{
            interactor?.fetchAQIData()
        }
    }
    
    var router: AQIRouter?
    
    private var latestData: [AQIRecord] = [AQIRecord]()
    private var lastWriteTimeStamp: Date = Date()
    
    func interactorDidfetchedData(With result: Result<Any, Error>) {
        
        switch result{
            
        case .success(let aQIData) :
            print("Success Data in Presenter")
            
            guard let datalist : [AQIData] = aQIData as? [AQIData] else {
                print ("Error in Presenter unable to map aqiData")
                return
            }
            
            //process and store in DB
            for element in datalist{
                let aqiData:AQIData = element
                
                let timestamp = Date()
                if let updatingCity = latestData.first(where: {$0.city == aqiData.city!}) {
                    updatingCity.timestamp = timestamp
                    updatingCity.aqi = aqiData.aqi!
                } else {
                    latestData.append(AQIRecord(city: aqiData.city!, aqi:aqiData.aqi!, timestamp: timestamp))
                }
                print("Objects in latest Data \(latestData.count)")
                DispatchQueue.main.async {
                    self.view?.updateViewWithData(data: self.latestData)
                }
            }

            //print("Now Process and write to db ")
            //check if timestamp isolder than 30 seconds
            //Write in db if certain interval passed let say add records in 30 minutes interval
             let calendar1 = Calendar.current
             let components = calendar1.dateComponents([.year,.month,.day,.hour,.minute,.second], from:  lastWriteTimeStamp, to:   Date())
             let seconds = components.second
             print("Seconds: \(seconds)")
            if ( seconds ?? 0 > Int(LIVE_TICKER_TIMING)){
                AQIDBHelper().writeBatchInDb(records: self.latestData)
                lastWriteTimeStamp = Date()
            }
            
            
        case .failure(let error) :
            print ("Error in Presenter \(error)")
            return
        }

        
    }
    
    //provides latest data toView
    func getLatestDataForCity(city: String)->AQIRecord? {
        if let updatingCity = latestData.first(where: {$0.city == city}) {
            return (AQIRecord(city: updatingCity.city!, aqi:updatingCity.aqi!, timestamp: updatingCity.timestamp!))
        }
        else {
            return nil
        }
    }
    
    //fetch historic data from db for city
    func getHistoricalDataForCity(city: String, seconds: Int)->[AQIRecord]?{
        var mainlist: [AQIRecord]? = [AQIRecord]()
        mainlist = AQIDBHelper().readHistoricalDataFor(city: city, seconds: seconds) ?? nil
        return mainlist
    }
    
}

