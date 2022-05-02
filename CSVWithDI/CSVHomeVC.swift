//
//  CSVHomeVC.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import UIKit

class CSVHomeVC: UIViewController {

    private let homeViewModel: CSVHomeViewModel
    private var userDataArray = [UserDataViewModel]()
    private let userCellIdentifier = "userCellIdentifier"
    private lazy var tableInfoList: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .systemBackground
        tb.register(UserTableViewCell.self, forCellReuseIdentifier: userCellIdentifier)
        return tb
    }()

    
    init(homeViewModel: CSVHomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
        self.homeViewModel.outputData = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
        getDataFromViewModel()
    }
    
    func setUIView() {
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(getDataFromViewModel))
        self.navigationItem.rightBarButtonItem  = refresh
        self.navigationItem.title = "Home CSV"
        view.backgroundColor = .systemBackground
        view.addSubview(tableInfoList)
        let views = ["table":self.tableInfoList]
        var constraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[table]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllTop, metrics: nil, views: views)
        self.view.addConstraints(constraints)
        let stringConstraint = "V:|-0-[table]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: stringConstraint, options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraints)
    }
    
    @objc func getDataFromViewModel() {
        homeViewModel.getDataFromCSV()
    }
}

extension CSVHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableInfoList.dequeueReusableCell(withIdentifier: userCellIdentifier) as? UserTableViewCell  else {
            return UserTableViewCell()
        }
        let obj = userDataArray[indexPath.row]
        cell.userInfoViewModel = obj
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CSVHomeVC: OutputDataForCSV {
    
    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?) {
        guard let userVM = userDataViewModel else { return }
        self.userDataArray = userVM
        DispatchQueue.main.async {
            self.tableInfoList.reloadData()
        }
    }

}


