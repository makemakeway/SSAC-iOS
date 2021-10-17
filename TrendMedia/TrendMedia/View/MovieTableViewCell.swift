//
//  MovieTableViewCell.swift
//  TrendMedia
//
//  Created by 박연배 on 2021/10/15.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    //MARK: Property
    
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var engTitle: UILabel!
    
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var korTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    
    //MARK: Method
    
    //MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
