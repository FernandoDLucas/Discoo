//
//  AlbumCells.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class AlbumCards: UICollectionViewCell {

    static let reuseIdentifier = "AlbumCards"
    var cover: UIImage?

    let artworkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let yearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func setupView() {
        self.addSubview(artworkImage)
        let arrayOfLabels = [albumLabel, artistLabel, yearLabel]
        arrayOfLabels.forEach {
            stackView.addArrangedSubview($0)
        }
        self.addSubview(stackView)
        arrayOfLabels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            artworkImage.topAnchor.constraint(equalTo: self.topAnchor),
            artworkImage.widthAnchor.constraint(equalTo: self.widthAnchor),
            artworkImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),

            stackView.topAnchor.constraint(equalTo: self.artworkImage.bottomAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func configure(image: Data, artist: String, year: Int32, name: String) {
        artworkImage.image = UIImage(data: image)
        artistLabel.text = artist
        yearLabel.text = {
            if year == 0 {
                return " "
            }
            return String(year)
        }()
        albumLabel.text = name
    }
}
