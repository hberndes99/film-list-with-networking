//
//  FilmListTableViewCell.swift
//  networking-with-film-api
//
//  Created by Harriette Berndes on 28/06/2021.
//

import UIKit
import SDWebImage

class FilmListTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel!
    private var ratingLabel: UILabel!
    private var filmImageLabel: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "filmCell")
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        contentView.addSubview(titleLabel)
        
        ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ratingLabel)
        
        filmImageLabel = UIImageView()
        filmImageLabel.frame = CGRect(x: 30, y: 10, width: 40, height: 70)
        filmImageLabel.clipsToBounds = true
        filmImageLabel.contentMode = .scaleAspectFill
        contentView.addSubview(filmImageLabel)
        
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
        NSLayoutConstraint.activate([
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 90),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
        NSLayoutConstraint.activate([
            filmImageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(for film: Film) {
        titleLabel.text = film.title
        ratingLabel.text = "\(film.vote_average)"
        if let imageUrl = film.poster_path {
            filmImageLabel.sd_setImage(with: URL(string:  "https://image.tmdb.org/t/p/w500\(imageUrl)"))
        }
        // filmImageLabel.image = UIImage(named: "harrypotter")
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
