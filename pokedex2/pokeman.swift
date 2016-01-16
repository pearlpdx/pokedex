//
//  pokeman.swift
//  pokedex2
//
//  Created by Home on 1/13/16.
//  Copyright © 2016 Pearlmanoffice. All rights reserved.
//

import Foundation
import Alamofire

class Pokeman {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _nextEvoTxt: String!
    
    private var _pokemonUrl: String!
    
    
    
    
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoTxt: String {
        if _nextEvoTxt == nil {
        _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
    var nextEvoLevel: String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    
    init(name: String, pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
        
    }
    
    func downloadPokemonDetails (completed: DownloadComplete) {
        
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary <String, AnyObject> {
                if let weight = dict["weight"] as? String {
                   self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                print(self._height)
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    
                    if let name = types[0] ["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x] ["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                            
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String,String>] where descriptions.count > 0 {
                    
                    if let url = descriptions[0] ["resource_uri"]  {
                        
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, nsurl).responseJSON { response in
                            let descResult = response.result
                            
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    
                                    print(self._description)
                                    
                                }
                            }
                            completed()
                    }
                    }
                } else {
                self._description = ""
                    
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0] ["to"] as? String {
                        
                        //mega pokemon not support by this app
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0] ["resource_uri"] as? String {
                                
                                let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvoId = num
                                self._nextEvoTxt = to
                                
                                if let lvl = evolutions[0] ["level"] as? Int {
                                    self._nextEvoLevel = "\(lvl)"
                                }
                                print(self._nextEvoId)
                                print(self._nextEvoTxt)
                                print(self._nextEvoLevel)
                            }
                        }
                    }
                    
                }
                
                
        }
        
    }
    
}
}