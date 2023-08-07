//
//  ViewController.swift
//  Case1
//
//  Created by Damla KS on 5.08.2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var launches: [SpaceXData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        indicatorView.startAnimating()
        takeData()
    }
    
    func takeData() {
        if let url = URL(string: "https://api.spacexdata.com/v4/launches/latest") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let launchData = try JSONDecoder().decode(SpaceXData.self, from: data)
                        self.launches.append(launchData)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }.resume()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpaceXCell
        
        let launch = launches[indexPath.row]
        cell.nameLabel.text = "Name: \(launch.name)"
        cell.detailsLabel.text = "Details: \(String(describing: launch.details))"
        
        if let imageURL = URL(string: launch.links?.patch?.small ?? "") {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        cell.patchImage.image = UIImage(data: imageData)
                        self.indicatorView.stopAnimating()
                        tableView.reloadData()
                    }
                }
            }
        }
        
        return cell
    }
}

