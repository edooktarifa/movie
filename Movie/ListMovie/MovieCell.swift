//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Edo Oktarifa on 22/04/21.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    let titleMovie : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    let imageMovie : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 40
        image.layer.masksToBounds = true
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
    
    func setContent(content: Movies){
        titleMovie.text = content.title
        imageMovie.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(content.img ?? "")"))
        
        imageMovie.kf.setImage(
            with: URL(string: "https://image.tmdb.org/t/p/w500/\(content.img ?? "")"),
            placeholder: UIImage(named: "ic-no_image"),
            options: [
                
            ],
            progressBlock: { receivedSize, totalSize in
                // Progress updated
            },
            completionHandler: { result in
                // Done
            }
        )
    }
    
}

