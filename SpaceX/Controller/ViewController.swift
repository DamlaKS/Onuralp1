//
//  ViewController.swift
//  SpaceX
//
//  Created by Damla KS on 5.08.2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var Launches: [SpaceXData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        manageAnimation(isWorking: true)
        fetchData()
    }
    
    private func setDelegates() {
        tableView.dataSource = self
    }
    
    private func manageAnimation(isWorking: Bool) {
        DispatchQueue.main.async { [self] in
            if isWorking {
                indicatorView.startAnimating()
            } else {
                indicatorView.stopAnimating()
            }
        }
    }
    
    private func fetchData() {
        Webservice().takeData { result in
            switch result {
            case .success(let launches):
                self.Launches = launches
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.manageAnimation(isWorking: false)
                }
            case .failure(_):
                self.manageAnimation(isWorking: false)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpaceXCell
        let launch = Launches[indexPath.row]
        cell.setObjects(name: "Name: \(launch.name)", details: "Details: \(String(describing: launch.details))", url: (launch.links?.patch!.small)!)
        if cell.patchImage.image == nil {
            tableView.reloadData()
        }
        return cell
    }
}
