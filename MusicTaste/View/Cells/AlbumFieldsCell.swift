//
//  AlbumFields.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

class AlbumFieldsCell : UITableViewCell {
    
    static let reuseIdentifier = "AlbumFieldCell"
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.adjustsFontSizeToFitWidth = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        setup()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.contentView.isUserInteractionEnabled = false
        self.addSubview(label)
        self.addSubview(textField)
    }
    
    private func configureLayout() {
        self.textField.clearButtonMode = .always
        NSLayoutConstraint.activate([
              label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
              label.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38),
              label.centerYAnchor.constraint(equalTo: self.centerYAnchor),

              textField.topAnchor.constraint(equalTo: self.topAnchor),
              textField.leftAnchor.constraint(equalTo: self.label.rightAnchor, constant: 16),
              textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
              textField.heightAnchor.constraint(equalToConstant: 44)
          ])
    }
}
