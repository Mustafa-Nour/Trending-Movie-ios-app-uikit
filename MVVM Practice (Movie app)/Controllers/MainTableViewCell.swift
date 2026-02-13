//
//  MainTableViewCell.swift
//  MVVM Practice (Movie app)
//
//  Created by Mustafa Nour on 26/02/2025.
//

import UIKit
import SDWebImage
class MainTableViewCell: UITableViewCell {

    
    public static var identifire: String {
        get {
            return "MainTableViewCell"
        }
    }
    public static func register() -> UINib {
             UINib(nibName: "MainTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var MovieImage: UIImageView!
    @IBOutlet weak var CellView: UIView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Modern card design with shadow instead of border
        CellView.round(16)
        MovieImage.round(10)
        
        // Clean background - white in light mode, dark in dark mode
        CellView.backgroundColor = UIColor { trait in
            return trait.userInterfaceStyle == .dark ? UIColor(white: 0.15, alpha: 1.0) : .white
        }
        
        // Add elegant shadow for depth
        CellView.layer.shadowColor = UIColor.black.cgColor
        CellView.layer.shadowOpacity = 0.1
        CellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        CellView.layer.shadowRadius = 8
        CellView.layer.masksToBounds = false
        
        // Better typography
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nameLabel.numberOfLines = 2
        
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = .secondaryLabel
        
        rateLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        // Shadow for poster image
        MovieImage.layer.shadowColor = UIColor.black.cgColor
        MovieImage.layer.shadowOpacity = 0.15
        MovieImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        MovieImage.layer.shadowRadius = 4
        MovieImage.layer.masksToBounds = false
        
        updateShadowForMode()
     }

     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
             updateShadowForMode()
         }
     }

     private func updateShadowForMode() {
         // Adjust shadow intensity based on mode
         if traitCollection.userInterfaceStyle == .dark {
             CellView.layer.shadowOpacity = 0.3
         } else {
             CellView.layer.shadowOpacity = 0.1
         }
     }

    func setUpCell(viewModel: MovieCellViewModel) {
        self.nameLabel.text = viewModel.name
        self.dateLabel.text = "📅 \(viewModel.date)"
        self.rateLabel.text = "⭐ \(String(viewModel.score ?? "0"))"
        self.MovieImage.sd_setImage(with: viewModel.imageURl)
        
        // Color-coded rating system
        
        if let ratingText = viewModel.score,
           let rating = Double(ratingText) {
            if rating >= 8.0 {
                self.rateLabel.textColor = UIColor(red: 0.2, green: 0.8, blue: 0.3, alpha: 1.0)
            } else if rating >= 6.0 {
                self.rateLabel.textColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0)
            } else {
                self.rateLabel.textColor = UIColor(red: 0.9, green: 0.2, blue: 0.3, alpha: 1.0)
            }
        }
    }
}

//cell extention

extension UIView {
    func round(_ radious: CGFloat = 13) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
}
