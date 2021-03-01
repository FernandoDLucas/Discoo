//
//  OnBoarding.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 01/03/21.
//

import UIKit

class OnBoardingViewController: UIViewController {

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    let addView: OnBoardingCell = {
        let view = OnBoardingCell()
        view.titleLabel.text = "Registre os álbuns"
        view.resumeLabel.text = "Adicione seus álbuns"
        view.iconImage.image = UIImage(systemName: "plus.circle.fill")
        return view
    }()

    let saveView: OnBoardingCell = {
        let view = OnBoardingCell()
        view.titleLabel.text = "Registre os álbuns"
        view.resumeLabel.text = "Adicione seus álbuns"
        view.iconImage.image = UIImage(systemName: "plus.circle.fill")
        return view
    }()

    let interactView: OnBoardingCell = {
        let view = OnBoardingCell()
        view.titleLabel.text = "Registre os álbuns"
        view.resumeLabel.text = "Adicione seus álbuns"
        view.iconImage.image = UIImage(systemName: "plus.circle.fill")
        return view
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.stackView.addSubview(addView)
        self.stackView.addSubview(saveView)
        self.stackView.addSubview(interactView)
        self.view.addSubview(stackView)
        configurestackView()
        setupStackView()
    }

    func configurestackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }

    func setupStackView() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ]
        )
    }
}
