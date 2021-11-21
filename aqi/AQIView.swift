//
//  AQIView.swift
//  aqi
//
//  Created by vivek on 20/11/21.
//

import Foundation
import UIKit


protocol AQIViewProtocol{
    
    var presenter: AQIPresenter? {get set}
    
    func updateViewWithData(data: Any)
    func showErrorMsg(error: Error)
    
    
}

class AQIView: UIViewController, AQIViewProtocol, UITableViewDelegate, UITableViewDataSource{
    
    
    var presenter: AQIPresenter?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //register Cell here
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
    }
    
    
//  Mark: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }

    
    
    
//  Mark: AQIViewProtocol
    
    func updateViewWithData(data: Any) {
        print("data received")
    }
    
    func showErrorMsg(error: Error) {
        print("Error received")
    }
    
    
    
    

}
