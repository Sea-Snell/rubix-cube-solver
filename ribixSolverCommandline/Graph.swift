//
//  Graph.swift
//  ribixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

class Graph{
    var vertList: [String: Vertex]
    var size: Int
    
    init(){
        self.vertList = [String: Vertex]()
        self.size = 0
    }
    
    func addVertex(id: String) -> Vertex{
        var vert = Vertex(id: id)
        self.vertList[id] = vert
        self.size += 1
        return vert
    }
    
    func getVertex(id: String) -> Vertex?{
        if var i = self.vertList[id]{
            return i
        }
        return nil
    }
    
    func addEdge(t: String, f: String, weight: String){
        if self.vertList[t] == nil{
            addVertex(t)
        }
        
        if self.vertList[f] == nil{
            addVertex(f)
        }
        
        self.vertList[f]?.connect(t, weight: weight)
    }
    
    func getVertices() -> [String: Vertex]{
        return self.vertList
    }
}
