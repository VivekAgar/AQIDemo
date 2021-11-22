//
//  AQIGraphViewController.swift
//  aqi
//
//  Created by vivek on 21/11/21.
//

import Foundation
import UIKit
import Charts

class AQIGraphViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var aQIValueLabel: UILabel!
    
    @IBOutlet weak var barchartViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var graphChoicesSegmentControl: UISegmentedControl!
    var cityName: String = ""
    var presenter: AQIPresenter?
    private var timer: Timer?
    private var i = 0
    
    private var timing : [Double] = [Double]()
    private var aqiValues: [Double]  = [Double]()
    private var dataEntries: [BarChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.barChartView.delegate = self
        self.cityNameLabel.text = "" + self.cityName
        self.barChartView.isUserInteractionEnabled = false
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
        }
    
    
    @IBAction func acSegmentAction(_ sender: Any) {
        
        switch graphChoicesSegmentControl.selectedSegmentIndex {
        case 0:
            print("1 selected")
            self.resetChartData()
            self.timer = Timer.scheduledTimer(timeInterval: LIVE_TICKER_TIMING, target:self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
        case 1:
            self.resetChartData()
            //Ask presenter for historic data
            if let datalist:[AQIRecord] = self.presenter?.getHistoricalDataForCity(city: self.cityName, seconds: 60 * 240){
                //prepare char dataset
                self.prepareChart(datalist: datalist)
            }
            else {
                self.barChartView.noDataText = "No data Avaiable"
            }
        case 2:
            self.resetChartData()
            print("2 selected")
            if let datalist:[AQIRecord] = self.presenter?.getHistoricalDataForCity(city: self.cityName, seconds: 60 * 480){
                //prepare char dataset
                self.prepareChart(datalist: datalist)
            }
            else {
                self.barChartView.noDataText = "No data Avaiable"
            }
            
        default:
            break;
        }
    }
    
    
    func resetChartData(){
        i = 0
        self.timer?.invalidate()
        self.timing = [Double]()
        self.aqiValues = [Double]()
        self.dataEntries = []
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "AQI")
        chartDataSet.drawValuesEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        //self.barChartView.drawValueAboveBarEnabled = false
        self.barChartView.notifyDataSetChanged()
        
        
    }
    
    private func prepareChart(datalist: [AQIRecord]){
        
        let recordsList = datalist
        var index = 0
        for element in recordsList{
            self.timing.append(Double(index * 30))
            self.aqiValues.append(Double(round(1000 * (element.aqi ?? 0.00)) / 1000))
            let dataEntry = BarChartDataEntry(x: Double(index), y: (Double(round(1000 * (element.aqi ?? 0.00)) / 1000)))
            dataEntries.append(dataEntry)
            index += 1
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "AQI")
        chartDataSet.drawValuesEnabled = false
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        //self.barChartView.drawValueAboveBarEnabled = false
        self.barChartView.notifyDataSetChanged()

        self.barchartViewWidthConstraint.constant = self.view.frame.width * 0.9
//        self.scrollView.contentSize = CGSize(width: CGFloat(width), height:self.scrollView.frame.height - 30)
        
    }
    
    //Poll data from Presenter 
    @objc func updateCounter(){
        //Get latest data from presenter and update the chart
        if let updatingCity = self.presenter?.getLatestDataForCity(city: self.cityName){
            
            self.aQIValueLabel.text = updatingCity.aqi?.format(f: ".2")
            timing.append(Double(i * 30))
            aqiValues.append(Double(round(1000 * (updatingCity.aqi ?? 0.00)) / 1000))
            
            let dataEntry = BarChartDataEntry(x: Double(i), y: aqiValues[i])
            self.barChartView.data?.addEntry(dataEntry, dataSetIndex: 0)
            
            dataEntries.append(dataEntry)
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "AQI")
            chartDataSet.drawValuesEnabled = false
            let chartData = BarChartData(dataSet: chartDataSet)
            barChartView.data = chartData
            //self.barChartView.drawValueAboveBarEnabled = false
            self.barChartView.notifyDataSetChanged()
            self.barChartView.xAxis.labelPosition = .bottom
            barChartView.leftAxis.axisMaximum = 550
            barChartView.rightAxis.axisMinimum = 0
            barChartView.rightAxis.axisMaximum = 550;
            barChartView.leftAxis.axisMinimum = 0;
            barChartView.leftAxis.enabled = false
            
            barChartView.leftAxis.drawTopYLabelEntryEnabled = false
            let backgroundColor: UIColor = setColor(aqiValue:Int(aqiValues[i]))
            self.aQIValueLabel.textColor = backgroundColor
            
            i = i + 1
            let width = dataEntries.count * 20
//            if (CGFloat(width) > self.view.frame.width){
                self.barchartViewWidthConstraint.constant = CGFloat(width)
                self.scrollView.contentSize = CGSize(width: CGFloat(width), height:self.scrollView.frame.height - 30)
//            }
//            else {
//                chartData.barWidth =  self.barChartView.frame.width * Double(0.20)
//            }
            //self.barChartView.moveViewToX(CGFloat(i))
    }
    
}

    func setColor(aqiValue: Int) -> UIColor{

        if(aqiValue < 50){
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
    
    
    
    
    
    
    
    
    
    
}

