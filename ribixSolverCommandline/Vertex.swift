//
//  Vertex.swift
//  ribixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

class Vertex{
    var id: String
    var connected: [String: String]
    var distance: Int
    var pre: Vertex?
    var color: String
    
    init(id: String){
        self.id = id
        self.connected = [String: String]()
        self.distance = 0
        self.pre = nil
        self.color = "white"
    }
    
    func connect(nbr: String, weight: String){
        self.connected[nbr] = weight
    }
    
    func getConnections() -> [String: String]{
        return self.connected
    }
    
    func getId() -> String{
        return self.id
    }
    
    func getWeight(nbr: String) -> String?{
        return self.connected[nbr]
    }
}