//
//  AQIInteractor.swift
//  aqi
//
//  Created by vivek on 20/11/21.
//

import Foundation
import Starscream


protocol AQIInteractorProtocol{
    var presenter: AQIPresenter? {get set}
    func fetchAQIData()
}


class AQIInteractor: AQIInteractorProtocol, WebSocketDelegate {
    
    var presenter: AQIPresenter?
    var websocket: WebSocket?
    func fetchAQIData() {
        print("Fetching Data...")
        let url = URL(string: "ws://city-ws.herokuapp.com/")!
        var request = URLRequest(url: url)
        request.timeoutInterval = 1
        websocket = WebSocket(request: request)
        websocket!.delegate = self
        websocket!.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
          print("connected \(headers)")
        case .disconnected(let reason, let closeCode):
          print("disconnected \(reason) \(closeCode)")
        case .text(let text):
          print("received text: \(text)")
            do {
            let entities = try JSONDecoder().decode([AQIData].self, from: Data(text.utf8))
            self.presenter?.interactorDidfetchedData(With: .success(entities))
            }
            catch{
                self.presenter?.interactorDidfetchedData(With: .failure(error))
            }
            
        case .binary(let data):
          print("received data: \(data)")
        case .pong(let pongData):
          print("received pong: \(pongData)")
        case .ping(let pingData):
          print("received ping: \(pingData)")
        case .error(let error):
          print("error \(error)")
        case .viabilityChanged:
          print("viabilityChanged")
        case .reconnectSuggested:
          print("reconnectSuggested")
        case .cancelled:
          print("cancelled")
        }
      }

    
    
    
}
