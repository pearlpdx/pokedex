//
//  PokemonDetailVC.swift
//  pokedex2
//
//  Created by Home on 1/14/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var decriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    var pokemon: Pokeman!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        mainLbl.text = pokemon.name.capitalizedString
        let img = UIImage(named: "\(pokemon.pokedexID)")
        mainImg.image = img
        currentEvoImg.image = img
        pokemon.downloadPokemonDetails { () -> () in
            // display afer download complete
            self.updateUI()
        }
            }
    
    func updateUI() {
      
        decriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIdLbl.text = "\(pokemon.pokedexID)"
        baseAttackLbl.text = pokemon.attack
        
        if pokemon.nextEvoId == "" {
            evoLbl.text = "No Evolution"
            nextEvoLbl.hidden = true
        } else {
            
        nextEvoLbl.hidden = false
        nextEvoLbl.image = UIImage(named: pokemon.nextEvoId)
        var str = "Next Evolution: \(pokemon.nextEvoTxt)"
            if pokemon.nextEvoLevel != "" {
                str += " - LVL \(pokemon.nextEvoLevel)"
            }
        evoLbl.text = str
    }
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
   
}
