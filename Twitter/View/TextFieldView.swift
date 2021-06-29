//
//  TextFieldView.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class TextFieldView: UIView {

    var placeHolder = "placeholder"
    
    let imageView: UIImageView = {
       let iv = UIImageView(image: UIImage(systemName: "envelope"))
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.font = UIFont.systemFont(ofSize: 16)
        return tf
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    convenience init(placeholder: String, image: String) {
        self.init()
        self.placeHolder = placeholder
        if let imagen = UIImage(systemName: image)  {
            self.imageView.image = imagen
        }
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(imageView)
        addSubview(textField)
        addSubview(dividerView)
        dividerView.anchor(left:leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        imageView.centerY(inView: self)
        imageView.setDimensions(width: 24, height: 24)
        imageView.anchor(left: leftAnchor,paddingLeft: 8)
        textField.anchor(top: topAnchor, left: imageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 4)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                                        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])

    }
}
