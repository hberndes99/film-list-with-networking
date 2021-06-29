//
//  DetailFilmPopUpView.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 29/06/2021.
//

import UIKit

protocol DetailFilmPopUpViewDelegate {
    func handleCancelTapped(popUpView: DetailFilmPopUpView)
    
    func handleAddTapped(selectedFilm: Film)
}

class DetailFilmPopUpView: UIView {
    
    private var titleLabel: UILabel!
    private var ratingLabel: UILabel!
    private var overviewLabel: UILabel!
    private var cancelButton: UIButton!
    private var addButton: UIButton!
    private var container: UIView!
    
    weak var delegate: ViewController?
    var selectedFilm: Film
    
    init(frame: CGRect, selectedFilm: Film) {
        
        self.selectedFilm = selectedFilm
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = selectedFilm.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.numberOfLines = 0
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.text = "Rating: \(selectedFilm.vote_average)"
        ratingLabel.numberOfLines = 0
        
        //can i make this a scrollable view instead of just normal
        overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.text = selectedFilm.overview
        overviewLabel.numberOfLines = 0
        
        cancelButton = UIButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.layer.cornerRadius = 5
        cancelButton.backgroundColor = .green
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = 5
        addButton.backgroundColor = .blue
        addButton.setTitle("Add to watchlist", for: .normal)
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white
        container.layer.cornerRadius = 24
        self.addSubview(container)
        
        container.addSubview(titleLabel)
        container.addSubview(ratingLabel)
        container.addSubview(overviewLabel)
        container.addSubview(cancelButton)
        container.addSubview(addButton)
        setUpConstraints()
        
        self.frame = UIScreen.main.bounds
        //self.backgroundColor = .gray
        self.frame = CGRect(x: 45, y: 150, width: self.frame.size.width - 90, height: self.frame.size.height-200)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            titleLabel.widthAnchor.constraint(equalTo: container.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            overviewLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 30),
            overviewLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 15),
            overviewLabel.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 0.8)
        ])
        NSLayoutConstraint.activate([
            cancelButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 150),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 150),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 15)
        ])
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1)
        ])
    }
    
    @objc func addTapped() {
        print("add tapped")
    }
    
    @objc func cancelTapped() {
        print("cancel tapped")
        delegate?.handleCancelTapped(popUpView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
