//
//  ViewController.swift
//  CoverFlowLayout
//
//  Created by xcode on 2024/11/11.
//

import UIKit

class ViewController: UIViewController {

    private var tableList: UITableView!
    
    private var coverFlowView: CoverFlowViewController!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        tableList = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        tableList.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
        tableList.delegate = self
        tableList.dataSource = self
        self.view.addSubview(tableList)
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coverFlowView = CoverFlowViewController()
        self.navigationController!.pushViewController(coverFlowView, animated: true)
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.textLabel?.text = "CoverFlow"
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
