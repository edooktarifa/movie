//
//  DetailMovieVC.swift
//  Movie
//
//  Created by Edo Oktarifa on 22/04/21.
//

import UIKit

class DetailMovieVC: UIViewController {

    let detailMovieLabel: UILabel = {
        let detail = UILabel()
        detail.textColor = .black
        detail.font = .systemFont(ofSize: 14)
        detail.textAlignment = .center
        return detail
    }()
    
    let detailMovieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    var detail : String?
    var imageMovie : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(detailMovieLabel)
        view.addSubview(detailMovieImage)
        
        detailMovieImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: view.frame.height / 3, enableInsets: false)
        
        detailMovieLabel.anchor(top: detailMovieImage.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: false)
        
        detailMovieImage.kf.setImage(with: URL(string: "https://image.tmdb.org/t/p/w500/\(imageMovie ?? "")"))
        detailMovieLabel.text = detail
    }

}
