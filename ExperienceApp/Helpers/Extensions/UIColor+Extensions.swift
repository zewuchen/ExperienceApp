//
//  UIColor+Extensions.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 14/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

extension UIColor {
    static var vermelhoTijolo: UIColor {
        return #colorLiteral(red: 0.7111877799, green: 0.2967664301, blue: 0.2963447571, alpha: 1)
    }

    static var background: UIColor {
        return #colorLiteral(red: 0.9607003331, green: 0.9608382583, blue: 0.9606701732, alpha: 1)
    }

    static var esgotado: UIColor {
        return #colorLiteral(red: 0.6971364617, green: 0.4479205012, blue: 0.4492017031, alpha: 1)
    }
    
    static var RosaSelecionado: UIColor {
        return #colorLiteral(red: 0.9931663871, green: 0.6809696555, blue: 0.6834092736, alpha: 1)
    }
}

extension UIFont {
    
    static var Rockwell30: UIFont {
        return UIFont(name: "Rockwell", size: 30) ?? systemFont(ofSize: 30)
    }
    static var RockwellBold30: UIFont {
        return UIFont(name: "Rockwell-Bold", size: 30) ?? systemFont(ofSize: 30, weight: .bold)
    }
    static var Rockwell24: UIFont {
        return UIFont(name: "Rockwell", size: 24) ?? systemFont(ofSize: 24)
    }
    static var RockwellBold24: UIFont {
        return UIFont(name: "Rockwell-Bold", size: 24) ?? systemFont(ofSize: 24, weight: .bold)
    }
    static var Rockwell20: UIFont {
        return UIFont(name: "Rockwell", size: 20) ?? systemFont(ofSize: 20)
    }
    static var RockwellBold20: UIFont {
        return UIFont(name: "Rockwell", size: 20) ?? systemFont(ofSize: 20, weight: .bold)
    }
    static var Rockwell18: UIFont {
        return UIFont(name: "Rockwell", size: 18) ?? systemFont(ofSize: 18)
    }
    static var RockwellBold18: UIFont {
        return UIFont(name: "Rockwell-Bold", size: 18) ?? systemFont(ofSize: 18)
    }
    static var AvenirRoman: UIFont {
        return UIFont(name: "Avenir-Roman", size: 18) ?? systemFont(ofSize: 18)
    }
    static var AvenirHeavy: UIFont {
        return UIFont(name: "Avenir-Heavy", size: 18) ?? systemFont(ofSize: 18, weight: .semibold)
    }
}
