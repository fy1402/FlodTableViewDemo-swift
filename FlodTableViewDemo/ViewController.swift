//
//  ViewController.swift
//  FlodTableViewDemo
//
//  Created by 丰雨 on 2017/4/5.
//  Copyright © 2017年 Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var datas: [CellModel1] = []
    var indexPaths = [IndexPath]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadDatas()
        setupTableView()
    }
    
    func loadDatas() {
        for i in 0...10 {
            
            let str = i.description
            let model = CellModel1(name: str, isOpen: false, rows: [])
            
            for j in 0...3 {
                model.rows.append(j.description)
            }
            datas.append(model)
        }
        
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("did select row \(indexPath.section)  -- \(indexPath.row)")
        
        if indexPath.row == 0 {

            for (index, item) in datas.enumerated() {
                print("index: \(index)  --- item: \(item)")
                if index == indexPath.section {
                    item.isOpen = !item.isOpen!
                } else {
                    item.isOpen = false
                }
            }
            
            var arr = [IndexPath]()
            
            let indexPath = IndexPath(row: 0, section: indexPath.section)
            arr.append(indexPath)
            var i = 0
            for _ in datas[indexPath.section].rows {
                let indexPath1 = IndexPath(row: i, section: indexPath.section)
                i += 1
                arr.append(indexPath1)
            }
            tableView.reloadRows(at: arr + self.indexPaths, with: .fade)
            self.indexPaths = arr  //上一次的section（为了艾泽拉斯😢）
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = datas[indexPath.section]
        if indexPath.row == 0 {
            return 40.0
        } else {
            if model.isOpen! {
                return 40.0
            } else {
                return 0.00001
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows: Int = datas[section].rows.count
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCell
            
            if let str = datas[indexPath.section].name {
                cell?.label?.text = str
            }
            return cell!
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell2")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cell2")
            }
            let rows = datas[indexPath.section].rows
            cell?.textLabel?.text = rows[indexPath.row]
            return cell!
        }
    }
    
    
}

struct CellModel {  //struct 深拷贝
    var name: String?
    var isOpen: Bool?
    var rows: [String] = []
}

class CellModel1 {
    var name: String?
    var isOpen: Bool?
    var rows: [String] = []
    
    convenience init(name: String, isOpen: Bool, rows: [String]) {
        self.init()
        self.name = name
        self.isOpen = isOpen
        self.rows = rows
    }
}
