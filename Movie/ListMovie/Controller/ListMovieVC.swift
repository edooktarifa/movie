//
//  ViewController.swift
//  Movie
//
//  Created by Edo Oktarifa on 22/04/21.
//

import UIKit
import RxSwift

class ListMovieVC: UIViewController {
    
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MovieCell.self, forCellReuseIdentifier: "MovieCell")
        return tableView
    }()
    
    var viewModel = ListVM()
    var showListMovie : [Movies]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureTable()
    }
    
    //MARK: - setup Table
    func configureTable() {
        title = "List Movie"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        loadData()
    }
    
    //MARK: - load Data
    func loadData(){
        viewModel.request { (movie) in
            self.showListMovie = movie
            self.tableView.reloadData()
        } error: { (error) in
            print(error.localizedDescription)
        }
        
        if showListMovie == nil{
            viewModel.loadData { (movie) in
                self.showListMovie = movie
                self.tableView.reloadData()
            }
        }
    }
    
}

//MARK: - extension viewcontroller
extension ListMovieVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showListMovie?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if showListMovie != nil{
            if let showMovie = showListMovie?[indexPath.row]{
                cell.setContent(content: showMovie)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailMovieVC()
        vc.detail = showListMovie?[indexPath.row].title
        vc.imageMovie = showListMovie?[indexPath.row].img
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
