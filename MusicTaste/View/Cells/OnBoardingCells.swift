//
//  OnBoardingCells.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 01/03/21.
//

import UIKit

class OnBoardingCell: UIView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let resumeLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let iconImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.calmPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLabels() {
        self.addSubview(titleLabel)
        self.addSubview(resumeLabel)
        self.addSubview(iconImage)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            self.iconImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 17),
            self.iconImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            self.iconImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.iconImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        )

        NSLayoutConstraint.activate([
            self.titleLabel.leftAnchor.constraint(equalTo: self.iconImage.rightAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        )

        NSLayoutConstraint.activate([
            self.resumeLabel.leftAnchor.constraint(equalTo: self.iconImage.rightAnchor),
            self.resumeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.resumeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -17)
        ]
        )
    }
}
