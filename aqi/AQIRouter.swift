//
//  AQIRouter.swift
//  aqi
//
//  Created by vivek on 20/11/21.
//

import Foundation

typealias Entry = AQIView & AQIViewProtocol

protocol AQIRouterProtocol{
    
    var entry: Entry? { get }
    //entry point
    static func start()->AQIRouterProtocol
    
}

class AQIRouter: AQIRouterProtocol{

    var entry:Entry?
    
    static func start() ->AQIRouterProtocol{
        
        
        let router = AQIRouter()
        let view: AQIView = AQIView()
        let interactor: AQIInteractor = AQIInteractor()
        let presenter: AQIPresenter = AQIPresenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        router.entry = view
        return router
    }
    
    
    
}
