//
//  SpaceXCell.swift
//  SpaceX
//
//  Created by Damla KS on 7.08.2023.
//

import UIKit

class SpaceXCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var patchImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setObjects(name: String, details: String, url: String) {
        nameLabel.text = name
        detailsLabel.text = details
        setImageWithUrl(url: url)
    }
    
    private func setImageWithUrl(url: String) {
        if let imageURL = URL(string: url) {
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, response, error in
                guard let self = self, let imageData = data, error == nil else {return}
                DispatchQueue.main.async {
                    self.patchImage.image = UIImage(data: imageData)
                }
            }.resume()
        }
    }
    
}
