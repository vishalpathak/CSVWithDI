//
//  CSVHomeVC.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import UIKit

class CSVHomeVC: UIViewController {

    private let homeViewModel: CSVHomeViewModel
    private var userDataArray: [UserDataViewModel]?
    
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
        view.backgroundColor = .white
    }
    
    @objc func getDataFromViewModel() {
        homeViewModel.getDataFromCSV()
    }

}

extension CSVHomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UserTableViewCell()
    }
    
}

extension CSVHomeVC: OutputDataForCSV {
    
    func receivedOutputData(userDataViewModel: [UserDataViewModel]?, error: Error?) {
        self.userDataArray = userDataViewModel
    }

}


