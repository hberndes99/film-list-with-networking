//
//  ViewController.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import UIKit

var filmList = FilmList(results: [])

class ViewController: UIViewController {
    
    private var filmTable: UITableView!
    private var searchBar: UISearchBar!
    private var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        //searchBar = UISearchBar(frame: CGRect(x: 0.0, y: 0.0, height: 50.0, width: tableView.frame.width))
        //searchBar.placeholder = "search for films by title"
        //searchBar.delegate = self
      
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        
        filmTable = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        filmTable.translatesAutoresizingMaskIntoConstraints = false
        filmTable.dataSource = self
        filmTable.delegate = self
        filmTable.register(FilmListTableViewCell.self, forCellReuseIdentifier: "filmCell")
    
    
        view.addSubview(filmTable)
        
        
        
        setUpConstraints()
        
        NetworkingManager.getFilmsByTitle(title: "parent trap") { [weak self] films in
            filmList.results = films
            self?.filmTable.reloadData()
        }
    }
    
    func setUpConstraints() {
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
        //self.searchController.searchBar.becomeFirstResponder()
        

     
    }


}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmList.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = filmTable.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath) as! FilmListTableViewCell
        let film = filmList.results[indexPath.row]
        cell.configureCell(for: film)
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFilm = filmList.results[indexPath.row]
        print(selectedFilm)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 70
        return height
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkingManager.getFilmsByTitle(title: searchText) {[weak self] films in
            filmList.results = films
            self?.filmTable.reloadData()
        }
    }
    
    
}
