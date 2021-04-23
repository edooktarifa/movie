//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Edo Oktarifa on 22/04/21.
//

import UIKit

class MovieCell: UITableViewCell {
    
    let titleMovie : UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()
    
    let imageMovie : UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 40
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        image.clipsToBounds = true
        return image
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    //MARK: - setupUI
    func configureUI() {
        contentView.addSubview(titleMovie)
        contentView.addSubview(imageMovie)
        
        imageMovie.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 80, height: 0, enableInsets: false)
        
        titleMovie.anchor(top: topAnchor, left: imageMovie.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        
        imageMovie.image = #imageLiteral(resourceName: "flutterImg")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

