//
//  ViewController.swift
//  pokedex
//
//  Created by Andre Rosa on 11/07/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var filterPokemon = [Pokemon]()
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done // troca o nome do bottao search do teclado
        
        parsePokemonCSV()
        initAudio()
    }
    
    //configura o audio
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        do{
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError{
            print(err.debugDescription)
            
        }
    }
    
    
    //pega os dados que estao dentro do arquivo
    func parsePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")! //a funcao de importar o arquivo
        
        do { // fazer mais isso
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows)
            
            for row in rows{
                let pokeId = Int(row["id"]!)
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId!)
                
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as? PokemonCell{
        
            let poke: Pokemon!
            
            if inSearchMode{
                poke = filterPokemon[indexPath.row]

            } else{
                poke = pokemon[indexPath.row]
            }
            
            cell.configureCell(poke)
            
            return cell
        } else{
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var poke: Pokemon!
        //fazendo isso setando o index path já esta referenciando a celula tocada
        if inSearchMode{
            poke = filterPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        //envia o objeto para o outro controller obs a segue foi criada se um viewcontroller para outro viewcontroller
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filterPokemon.count
        }
        
        return pokemon.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    
    @IBAction func musicBtnPress(_ sender: UIButton) { // eu consigo estilizar o bottao setando o sender como uibutton assim nao precisando criar um iboutlet
        if musicPlayer.isPlaying{
            musicPlayer.pause()
            sender.alpha = 0.2
        } else{
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)// tira o focus do campo e esconde o teclado
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true) // tira o focus do campo e esconde o teclado
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            //faz o filtro dentro do objeto de acordo com os atributos especificados
            filterPokemon = pokemon.filter({ $0.name.range(of: lower) != nil })
            collection.reloadData()
            
        }
    }
    // é como configura para passar dados entre views controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            
            
            //isso faco pois a segue esta indo para uma navigationcontroller
            let navController = segue.destination as! UINavigationController

            // estou dizendo que estou procurando a view que esta dentro do navigation controller do tipo 'PokemonDetailVC'
            if let detailsVC = navController.topViewController as? PokemonDetailVC {
                // 'poke' é o objeto que eu atribui na funcao 'prepare for segue'
                if let poke = sender as? Pokemon {
                    // estou dizendo que 'detailsVC' que é meu destino tem uma variavel 'pokemon' e estou atribuindo um valor a ela
                    detailsVC.pokemon = poke
                }
            }
            
            /*  // desta forma é como faria para uma view comum
            if let detailsVC = segue.destination as? PokemonDetailVC {
                // 'poke' é o objeto que eu atribui na funcao 'prepare for segue'
                if let poke = sender as? Pokemon {
                    // estou dizendo que 'detailsVC' que é meu destino tem uma variavel 'pokemon' e estou atribuindo um valor a ela
                    detailsVC.pokemon = poke
                }
            }*/
            
        }
    }
    
    
}

