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
    var watchList: [Film] = [Film]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for films by name"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Watch list", style: .plain, target: self, action: #selector(showWatchList))
        
        filmTable = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        filmTable.translatesAutoresizingMaskIntoConstraints = false
        filmTable.dataSource = self
        filmTable.delegate = self
        filmTable.register(FilmListTableViewCell.self, forCellReuseIdentifier: "filmCell")
    
        view.addSubview(filmTable)
        
        setUpConstraints()
        
        NetworkingManager.getFilmsByTitle(title: "the parent trap") { [weak self] films in
            filmList.results = films
            DispatchQueue.main.async {
                self?.filmTable.reloadData()
            }
    
        }
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            filmTable.topAnchor.constraint(equalTo: view.topAnchor),
            filmTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filmTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filmTable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func showWatchList() {
        let watchListVC = WatchListViewController(watchList: watchList)
        navigationController?.pushViewController(watchListVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let savedFilms = userDefaults.data(forKey: "savedToWatchList") {
            if let savedFilms = try? jsonDecoder.decode([Film].self, from: savedFilms) {
                watchList = savedFilms
            }
        }
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
        cell.selectionStyle = .none
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFilm = filmList.results[indexPath.row]
        
        let detailFilmViewController = DetailFilmViewController(selectedFilm: selectedFilm)
        detailFilmViewController.delegate = self
        present(detailFilmViewController, animated: true)
        /*
        let popUpView = DetailFilmPopUpView(frame: .zero, selectedFilm: selectedFilm)
        self.popUpView = popUpView
       
        popUpView.delegate = self
        filmTable.alpha = 0.2
        print(view.subviews.count)
        view.addSubview(popUpView)
        print(view.subviews.count)
        */
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = 90
        return height
    }
}


extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkingManager.getFilmsByTitle(title: searchText) {[weak self] films in
            filmList.results = films
            DispatchQueue.main.async {
                self?.filmTable.reloadData()
            }
        }
    }
}


extension ViewController : DetailFilmPopUpViewDelegate {
    func handleCancelTapped() {
        dismiss(animated: true)
    }
    
    func handleAddTapped(selectedFilm: Film) {
        if (!watchList.contains(selectedFilm)) {
            watchList.append(selectedFilm)
            
            if let savedFilms = userDefaults.data(forKey: Constants.savedFilms), var decodedSavedFilms = try? jsonDecoder.decode([Film].self, from: savedFilms) {
                    decodedSavedFilms.append(selectedFilm)
                    if let decodedSavedFilms = try? jsonEncoder.encode(decodedSavedFilms) {
                        userDefaults.set(decodedSavedFilms, forKey: Constants.savedFilms)
                    }
                }
            else {
                print("list currently empty")
                // no films currently in watch list
                let savedFilm = [selectedFilm]
                if let encodedFilm = try? jsonEncoder.encode(savedFilm) {
                    userDefaults.set(encodedFilm, forKey: Constants.savedFilms)
                    print("works")
                }
            }
            
        }
        
        else {
            print("alr in watch list")
        }
        dismiss(animated: true)
    }
}
