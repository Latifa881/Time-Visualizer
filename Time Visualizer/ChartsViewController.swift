//
//  ChartsViewController.swift
//  Time Visualizer
//
//  Created by administrator on 23/12/2021.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    @IBOutlet weak var pieView: UIView!
    @IBOutlet weak var barView: UIView!
    
    var events = [Event]()
    var tasks = [String]()
    var numberOfApperence = [Double]()
    
    let pieChartView = PieChartView(frame: .zero)
    let barChartView = BarChartView(frame: .zero)
    
    var tasksDetails : [EventEntity]?
    let colors: [UIColor] = [
        .systemMint, .systemYellow, .systemRed,
        .systemBlue, .systemGreen, .systemBrown
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        grabTasksToAnalyzeData()
        makePieChart()
        makeBarChart()
    }
    
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func makePieChart(){
        let dataPoints = tasks
        let values = numberOfApperence
        pieChartView.frame = pieView.frame
        pieChartView.isHidden = false
        view.addSubview(pieChartView)
        
        var dataEntries: [ChartDataEntry] = []
          for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
          }
          // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: nil)
        pieChartDataSet.colors = self.colors
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChartView.data = pieChartData
    }
    
    func makeBarChart(){
        let dataPoints = tasks
        let values = numberOfApperence
        barChartView.frame = self.barView.frame
        view.addSubview(barChartView)
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<dataPoints.count {
          let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Bar Chart View")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }

    
    func grabTasksToAnalyzeData() {
        
        guard let tasksDetails = tasksDetails else {return }
        
        for i in tasksDetails{
            
            guard let task = i.task else {return }
            
            tasks.append(task)
        }
        
        let countedSet = NSCountedSet(array: tasks)
           // 3
        for value in countedSet {
            print("Element:", value, "count:", countedSet.count(for: value))
            events.append(Event(task: value as! String,count: Double(countedSet.count(for: value))))
        }
        tasks.removeAll()
        
        for task in events {
            tasks.append(task.task)
        }
        


        for eventCount in events{
            numberOfApperence.append(eventCount.count)
        }
        print("counts:: \(numberOfApperence)")
        

        
       
        
    }

    

}

struct Event {
    var task : String
    var count : Double = 1
}

