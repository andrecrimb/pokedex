//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Andre Rosa on 14/07/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    // variavel para pegar os dados enviados da segue
    var pokemon: Pokemon!
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = pokemon.name.capitalized
    }

    @IBAction func backBtnPress(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
