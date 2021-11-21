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
    var view: AQIView?
    
    var interactor: AQIInteractor? {
        didSet{
            interactor?.fetchAQIData()
        }
    }
    
    var router: AQIRouter?
    
    func interactorDidfetchedData(With result: Result<Any, Error>) {
        
        switch result{
            
        case .success(let aQIData) :
            print("Success Data in Presenter")
            print("Now Process and write to db ")
            
            
        case .failure(let error) :
            print ("Error in Presenter \(error)")
            
        }
        
    }
    
    
    
}
