//
//  PaingTableViewController.swift
//  TableViewUpDownPaging
//
//  Created by BHJ on 2022/07/19.
//

import UIKit

struct CellData {
    let title: String
}



class PaingTableViewController: UITableViewController {
    
    var cellDatas: [CellData] = []
    
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    
    var selectedRow: [Int] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    func setData() {
        
        var datas: [CellData] = []
        
        for i in 0..<100 {
            let title: String = "플레이 리스트\(i)번"
            let data = CellData(title: title)
            datas.append(data)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.cellDatas.append(contentsOf: datas)

            self.hasNextPage = self.cellDatas.count > 300 ? false : true
            self.isPaging = false
            
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        self.tableView.rowHeight = UITableView.automaticDimension
        selectedRow = UserDefaults.standard.value(forKey: "selected") as? [Int] ?? []
        print("selectedRow\(selectedRow)")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellDatas.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }

        cell.titleLabel.text = cellDatas[indexPath.row].title
        
        if selectedRow.contains(indexPath.row) {
            cell.imgView.image =   UIImage(named: "ic_pause_24")
            cell.backgroundColor = .blue
        } else {
            cell.imgView.image =  UIImage(named: "ic_play_24")
            cell.backgroundColor = .clear
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("First seletedRows \(selectedRow.filter{$0 != indexPath.row})")
        selectedRow.removeAll()
        if selectedRow.contains(indexPath.row) {
            self.selectedRow = selectedRow.filter{$0 != indexPath.row}
        }else{
            self.selectedRow.append(indexPath.row)
        }
        print("Second seletedRows \(selectedRow)")
        UserDefaults.standard.set(selectedRow, forKey: "selected")
    }
    
    // MARK: - Table view delegate source
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return  82
//    }
}
