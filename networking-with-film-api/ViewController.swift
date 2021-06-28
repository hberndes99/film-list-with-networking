//
//  ViewController.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import UIKit

var filmList = FilmList(results: [
    Film(title: "test", id: 1, overview: "", vote_average: 1.0),
    Film(title: "test 1", id: 2, overview: "", vote_average: 1.0)
])

class ViewController: UIViewController {
    
    private var filmTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        filmTable = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        filmTable.translatesAutoresizingMaskIntoConstraints = false
        filmTable.dataSource = self
        filmTable.delegate = self
        filmTable.register(FilmListTableViewCell.self, forCellReuseIdentifier: "filmCell")
        
        view.addSubview(filmTable)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
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
    
}
