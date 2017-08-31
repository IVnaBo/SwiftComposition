//
//  DetailVc.swift
//  SwiftComposition
//
//  Created by ivna.evecom on 2017/8/31.
//  Copyright © 2017年 ivna. All rights reserved.
//

import UIKit

class DetailVc: UITableViewController {
    let identify:String = "ID"
    var infoArr = [[String]]()
    var modelArr:[TestModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
         setupUI()
         setupData()
        
        
        // Do any additional setup after loading the view.
    }
    func setupData()  {
        
        let path = Bundle.main.path(forResource: "ImgCount", ofType: "plist")
        
        infoArr  = NSArray.init(contentsOf: URL.init(fileURLWithPath: path!)) as! [[String]]
        modelArr = [TestModel]()
        for var i in 0 ..< infoArr.count{
            let model = TestModel.init(data: infoArr[i])
            self.modelArr?.append(model)
        }
        self.tableView.reloadData()
    }
    func setupUI()  {
        self.tableView.register(NewsViewCell.classForCoder(), forCellReuseIdentifier: identify)
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.modelArr?.count)!
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! NewsViewCell
        cell.selectionStyle = .none
        while cell.middleView?.subviews.last != nil {//删除重用的cell的所有子视图
            cell.middleView?.subviews.last?.removeFromSuperview()
        }
        cell.testModel = self.modelArr?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.modelArr![indexPath.row].cell_H!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
