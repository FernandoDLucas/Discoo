//
//  AlbumFields.swift
//  MusicTaste
//
//  Created by Fernando de Lucas da Silva Gomes on 03/02/21.
//

import UIKit

protocol AlbumFieldsDelegate: class {
    func didUpdateTextField(text: String, field: AlbumFields)
}

class AlbumFieldsCell: UITableViewCell, UITextFieldDelegate {

    weak var delegate: AlbumFieldsDelegate?
    static let reuseIdentifier = "AlbumFieldCell"
    var identifier: AlbumFields?

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .systemBackground
        textField.adjustsFontSizeToFitWidth = true
        textField.font = .systemFont(ofSize: 15)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    let label: UILabel = {
        let label = UILabel()
        label.text = "Teste"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .label
        label.isUserInteractionEnabled = false
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.textField.addTarget(self, action: #selector(didChanged), for: .editingChanged)
        setup()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.contentView.isUserInteractionEnabled = false
        self.selectionStyle = .none
        self.addSubview(label)
        self.addSubview(textField)
    }

    public func configure(fieldName: String) {
        self.textField.delegate = self
        self.label.text = fieldName
        self.textField.placeholder = fieldName
        self.identifier = AlbumFields(rawValue: fieldName)
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

extension AlbumFieldsCell {

    @objc func didChanged(textField: UITextField) {
        if let text = textField.text, let identifier = self.identifier {
            self.delegate?.didUpdateTextField(text: text, field: identifier)
        }
    }
}
