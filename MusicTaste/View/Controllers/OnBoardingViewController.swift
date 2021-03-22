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
        view.resumeLabel.text = "Registre sobre o que deseja escrever"
        view.iconImage.image = UIImage(systemName: "plus.circle.fill")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let saveView: OnBoardingCell = {
        let view = OnBoardingCell()
        view.titleLabel.text = "Escreva sobre as músicas"
        view.resumeLabel.text = "Suas resenhas sobre as músicas são salvas automaticamente"
        view.iconImage.image = UIImage(systemName: "pencil")
        return view
    }()

    let interactView: OnBoardingCell = {
        let view = OnBoardingCell()
        view.titleLabel.text = "Interaja com os álbuns"
        view.resumeLabel.text = "Gerencie seus álbuns facilmente ao manter a tela pressionada"
        view.iconImage.image = UIImage(systemName: "cursorarrow.click")
        return view
    }()

    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Bem vindo ao Discoo"
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let doneLabel: UILabel = {
        let label = UILabel()
        label.text = "Continuar"
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.textColor = .calmPurple
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        self.stackView.addArrangedSubview(addView)
        self.stackView.addArrangedSubview(saveView)
        self.stackView.addArrangedSubview(interactView)
        self.view.addSubview(stackView)
        configurestackView()
        setupIconView()
        setupWelcomeLabel()
        setupStackView()
        setupDoneLabel()
    }

    func configurestackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 17
    }

    func setupStackView() {
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.welcomeLabel.bottomAnchor, constant: 30),
            self.stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3),
            self.stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }

    func setupIconView() {
        self.view.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            self.iconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 17),
            self.iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.iconImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3),
            self.iconImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3)
        ])
    }

    func setupWelcomeLabel() {
        self.view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            self.welcomeLabel.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor),
            self.welcomeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.welcomeLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
    }

    func setupDoneLabel() {
        self.view.addSubview(doneLabel)
        NSLayoutConstraint.activate([
            self.doneLabel.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 30),
            self.doneLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.doneLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
        ])
        let gesture = UITapGestureRecognizer(target: self, action: #selector(presentHome))
        self.doneLabel.addGestureRecognizer(gesture)
    }

    @objc func presentHome() {
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(1, forKey: "hasSeenOnboard")
    }
}
