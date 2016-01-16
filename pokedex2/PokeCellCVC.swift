//
//  PokeCellCVC.swift
//  pokedex2
//
//  Created by Home on 1/13/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class PokeCellCVC: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokeman!
    

    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokeman) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image =    UIImage(named: "\(self.pokemon.pokedexID)")
        
        
    }
    
}
