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
    
    private var tableData: [AQIRecord] = [AQIRecord]()
    
    private var selectedIndex = IndexPath(row: 0, section: 0)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        let aQITableViewCellnib = UINib(nibName: "AQITableViewCell", bundle: nil)
        tableView.register(aQITableViewCellnib, forCellReuseIdentifier: "AQITableViewCell")
        tableView.separatorColor = UIColor.clear
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.frame = self.view.frame
    }
    
    
    // Mark: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let record: AQIRecord = tableData[indexPath.row] as AQIRecord
        let cell: AQITableViewCell = tableView.dequeueReusableCell(withIdentifier: "AQITableViewCell") as! AQITableViewCell
        
        let (title, description) = self.setTitleAnddescription(aqiValue: Int(record.aqi ?? 0))
        
        let formattedaqiValue = record.aqi?.format(f: ".2") ?? "0.00"
        cell.aQIValueLabel.text = formattedaqiValue + " " + title
        
        cell.descriptionLabel.text = description
        cell.aQIValueLabel.textColor = self.setColor(aqiValue: Int(record.aqi ?? 0))
        cell.cityNameLabel.text  = " " +  record.city!
        cell.aQIGradientView.configureAQIGradientViewFor(aQIValue: record.aqi ?? 0.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        let record: AQIRecord = tableData[indexPath.row] as AQIRecord
        
        var aqiGraphViewController = AQIGraphViewController()
        aqiGraphViewController.presenter = self.presenter
        aqiGraphViewController.cityName = record.city!
        
        self.present(aqiGraphViewController, animated: true) {
            print("presented")
        }
    }
    
    // Mark : AQIViewProtocol
    
    func updateViewWithData(data: Any) {
        self.tableData = data as! [AQIRecord]
        self.tableView.reloadData()
    }
    
    func showErrorMsg(error: Error) {
        print("Error received")
    }
}

extension AQIView{
    
    func setColor(aqiValue: Int) -> UIColor{
        
        if(aqiValue <= 50){
            return AQILevel.good.value
        }
        else if(aqiValue >= 51 && aqiValue <= 100){
            return AQILevel.satisfactory.value
        }
        else if(aqiValue >= 101 && aqiValue <= 200){
            return AQILevel.modrate.value
        }
        else if(aqiValue >= 201 && aqiValue <= 300){
            return AQILevel.poor.value
        }
        else if(aqiValue >= 301 && aqiValue <= 400){
            return AQILevel.veryPoor.value
        }
        else if(aqiValue >= 401 && aqiValue <= 500){
            return AQILevel.severe.value
        }
        else { //In case anything goes wrong
            return UIColor.black
        }
    }
    
    func setTitleAnddescription(aqiValue: Int) -> (String, String){
        
        if(aqiValue < 50){
            return (AQILevel.good.title, AQILevel.good.description)
        }
        else if(aqiValue >= 51 && aqiValue <= 100){
            return (AQILevel.satisfactory.title, AQILevel.satisfactory.description)
        }
        else if(aqiValue >= 101 && aqiValue <= 200){
            return (AQILevel.modrate.title, AQILevel.modrate.description)
        }
        else if(aqiValue >= 201 && aqiValue <= 300){
            return (AQILevel.poor.title, AQILevel.poor.description)
        }
        else if(aqiValue >= 301 && aqiValue <= 400){
            return (AQILevel.veryPoor.title, AQILevel.veryPoor.description)
        }
        else if(aqiValue >= 401 && aqiValue <= 500){
            return (AQILevel.severe.title, AQILevel.severe.description)
        }
        else { //In case anything goes wrong
            return ("", "")
        }
    }
    
}
