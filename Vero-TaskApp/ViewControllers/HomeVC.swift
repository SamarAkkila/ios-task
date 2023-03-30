//
//  HomeVC.swift
//  Vero-TaskApp
//
//  Created by MacBook on 27/03/2023.
//  Copyright © 2023 SamarAkkila. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet weak var tableView  : UITableView!
    @IBOutlet weak var searchBar  : UISearchBar!
    @IBOutlet weak var btnRefresh : UIButton!
    
    
    var arrData       :[Task] = []
    var arrFilterdata :[Task] = []
    var searchActive  : Bool = false
   
    let refreshControl = UIRefreshControl()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setTable()
        getAllTasks()
        searchBar.delegate = self
        self.hideKeyboardWhenTappedAround()
        NetworkManager.shared.login()
        NotificationCenter.default.addObserver(self, selector: #selector(stopRefresh), name: Constants.stopRefresh, object: nil)
        refreshControl.addTarget(self, action: #selector(refreshButtonPressed), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
    }
    
    
    
    //MARK:- Functions
    
    
    func setTable(){
        tableView.tableFooterView   = UIView()
        tableView.separatorStyle    = .none
        tableView.delegateRegister(sender: self, cell: TasksTVCell.self)
    }
    
    
    //MARK:- This function get all tasks from core data and show them on tableview
    
    func getAllTasks(){
        do{
            let tasks = try context.fetch(Task.fetchRequest())
            self.arrData = tasks
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }catch{
            // error
        }
    }
    
    
    func PassSearchTxt(searchTxt: String) {
        
        searchBar.delegate?.searchBar?(searchBar, textDidChange: searchTxt)
        self.searchBar.text = searchTxt
        self.searchBar.becomeFirstResponder()
        
    }
    
    
    
    //MARK:- IBActions
    
    @objc func stopRefresh(sender:AnyObject){
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.btnRefresh.stopRotating()
            self.refreshControl.endRefreshing()
        }
        
    }
    
    
    @IBAction func refreshButtonPressed(_ sender: Any) {
        self.btnRefresh.startRotating()
        NetworkManager.shared.performTasks()
        getAllTasks()
    }
    
    @IBAction func scanButtonPressed(_ sender: Any) {
        searchBar.text = ""
        
        let vc : ScannerVC = Storyboard.instanceMain()
        vc.delegate = PassSearchTxt
        self.presentVC(vc: vc)
        
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return searchActive ? arrFilterdata.count : arrData.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TasksTVCell = tableView.dequeueTVCell()
        
        if(searchActive){
            cell.config_cell(object: arrFilterdata[indexPath.row])
            
        } else {
            cell.config_cell(object: arrData[indexPath.row])
        }
        
        return cell
    }
}




extension HomeVC: UISearchBarDelegate
{
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let searchStr = searchText.trimWhiteSpace()
        
        if searchStr != "", searchStr.count > 0 {
            let filterData = arrData.filter {
                return $0.title?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.task?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.desc?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.wageType?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.businessUnitKey?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.businessUnit?.range(of: searchStr, options: .caseInsensitive) != nil ||
                $0.sort?.range(of: searchStr, options: .caseInsensitive) != nil
            }
            
            self.arrFilterdata = filterData
            if(filterData.count == 0){
                searchActive = false
            } else {
                searchActive = true
            }
            self.tableView.reloadData()
        }else{
            searchActive = false
            self.tableView.reloadData()
        }
        
        
    }
}


