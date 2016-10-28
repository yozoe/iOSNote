//
//  ViewController.swift
//  SwiftProject
//
//  Created by wangdong on 2016/10/26.
//  Copyright © 2016年 wangdong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tools: HttpTool = HttpTool()
    
    // MARK:- hehe
    
    /// tableView的属性
    lazy var tableView:  UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupUI()
      
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        weak var weakself = self
        
        tools.loadData { (jsonData) in
            print("在viewController拿到数据:\(jsonData)")
        
            weakself!.view.backgroundColor = UIColor.redColor()
        
        }
        
        tools.loadData {[unowned self] (jsonData) in
            print("在viewController拿到数据:\(jsonData)")
            
            self.view.backgroundColor = UIColor.redColor()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//281771329460168

}

extension ViewController {
    func setupUI() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let CellID = "CellID"
        var cell = tableView.dequeueReusableCellWithIdentifier(CellID)
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: CellID)
        }
        
        cell?.textLabel?.text = "a"
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print("点击了\(indexPath.row)")
        XMGLog("点击了\(indexPath.row)")
    }
}

func XMGLog<T>(message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName)\(lineNum)\(message)")
}
