//
//  DetailFilmViewController.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 02/07/2021.
//

import UIKit


protocol DetailFilmPopUpViewDelegate {
    func handleCancelTapped()
    
    func handleAddTapped(selectedFilm: Film)
}

class DetailFilmViewController: UIViewController {
    private var selectedFilm: Film
    
    private var titleLabel: UILabel!
    private var ratingLabel: UILabel!
    private var filmImageView: UIImageView!
    private var overviewLabel: UILabel!
    private var cancelButton: UIButton!
    private var addButton: UIButton!
    var delegate: DetailFilmPopUpViewDelegate?
    
    init(selectedFilm: Film) {
        self.selectedFilm = selectedFilm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = selectedFilm.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        titleLabel.numberOfLines = 4
        view.addSubview(titleLabel)
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "Rating: \(selectedFilm.voteAverage)"
        ratingLabel.numberOfLines = 0
        view.addSubview(ratingLabel)
        
        filmImageView = UIImageView()
        filmImageView.frame = CGRect(x: 30, y: 30, width: 150, height: 200)
        filmImageView.clipsToBounds = true
        filmImageView.contentMode = .scaleAspectFill
        view.addSubview(filmImageView)
        
        filmImageView.image = UIImage(named: "unknown")
        
        //can i make this a scrollable view instead of just normal
        overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.text = selectedFilm.overview
        overviewLabel.numberOfLines = 0
        view.addSubview(overviewLabel)
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.layer.cornerRadius = 5
        cancelButton.backgroundColor = .green
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = 5
        addButton.backgroundColor = .blue
        addButton.setTitle("Add to watchlist", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        setUpConstraints()
        setUpImage()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            ratingLabel.leadingAnchor.constraint(equalTo: filmImageView.trailingAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            filmImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filmImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            filmImageView.widthAnchor.constraint(equalToConstant: 100),
            filmImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: filmImageView.bottomAnchor, constant: 30),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            overviewLabel.widthAnchor.constraint(equalToConstant: 350)
        ])
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15)
        ])

    }
    
    func setUpImage() {
        if let imageUrl = self.selectedFilm.posterPath {
            filmImageView.sd_setImage(with: URL(string:  "https://image.tmdb.org/t/p/w500\(imageUrl)"))
        } else {
            filmImageView.image = UIImage(named: "unknown")
        }
    }
    

    @objc func addTapped() {
        delegate?.handleAddTapped(selectedFilm: selectedFilm)
    }
    
    @objc func cancelTapped() {
        delegate?.handleCancelTapped()
    }

}
