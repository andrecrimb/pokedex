//
//  Constants.swift
//  pokedex
//
//  Created by Andre Rosa on 15/07/17.
//  Copyright © 2017 Andre Rosa. All rights reserved.
//

import Foundation

let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"
// como as requisicoes sao assincronas declarando esse typealias "clousure" crio uma funcao que é rodada em um tempo especifico nao fazendo o app dar crash
typealias DownloadComplete = () -> ()
