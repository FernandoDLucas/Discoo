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
    weak var delegate: DeleteCardDelegate?
    var index: IndexPath?

    let artworkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override func prepareForReuse() {
        albumLabel.text = ""
        artistLabel.text = ""
        yearLabel.text = ""
        stopAnimation()
    }

    let albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let yearLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let removeView: UIView = {
        let imageView = UIImageView()
        imageView.image = .remove
        imageView.isUserInteractionEnabled = true
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowRadius = 1.0
        imageView.clipsToBounds = false
        return imageView
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
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            artworkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            artworkImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            artworkImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65),
            artworkImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            stackView.topAnchor.constraint(equalTo: artworkImage.bottomAnchor, constant: 5),
            stackView.leftAnchor.constraint(equalTo: self.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: self.rightAnchor),
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

    func animate() {
        Animations.shakingAnimation(on: self)
        addDeleteButton()
    }

    func addDeleteButton() {
        self.addSubview(removeView)
        removeView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        removeView.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.removeView.alpha = 1
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectedDelete))
        removeView.addGestureRecognizer(gesture)
    }

    func stopAnimation() {
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2) {
            self.removeView.alpha = 0
        }
        self.removeView.removeFromSuperview()
    }
}

extension AlbumCards {
    @objc func didSelectedDelete() {
        self.delegate?.didSelectDelete(at: index!)
    }
}
