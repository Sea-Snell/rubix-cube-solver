//
//  2x2x2.swift
//  ribixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

class Rubix2x2x2{
    var startCube: String
    var endCube: String
    init(startCube: String){
        self.startCube = startCube
        self.endCube = ""
        self.endCube = self.getFinalPos()
    }
    
    func getFinalPos() -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in self.startCube{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var back = cube[2][2]
        var right = cube[3][3]
        var bottom: String = String(cube[5][3])
        var opposites: [String: String] = ["y": "w", "w": "y", "b": "g", "g": "b", "r": "o", "o": "r"]
        var string = ""
        for i in 0..<4{
            if var i = opposites[String(back)]{
                string += String(i)
            }
        }
        for i in 0..<4{
            if var i = opposites[String(right)]{
                string += i
            }
        }
        for i in 0..<4{
            string += String(back)
        }
        for i in 0..<4{
            string += String(right)
        }
        for i in 0..<4{
            if var i = opposites[String(bottom)]{
                string += i
            }
        }
        for i in 0..<4{
            string += String(bottom)
        }
        return string
    }
    
    func solveCube(){
        var graph = Graph()
        graph.addVertex(self.endCube)
        graph.addVertex(self.startCube)
        var vertQueue1 = Queue<Vertex>()
        vertQueue1.enquque(graph.vertList[self.endCube]!)
        var vertQueue2 = Queue<Vertex>()
        vertQueue2.enquque(graph.vertList[self.startCube]!)
        var frounteer1 = [String: Vertex]()
        var frounteer2 = [String: Vertex]()
        frounteer1[self.endCube] = graph.vertList[self.endCube]!
        frounteer2[self.startCube] = graph.vertList[self.startCube]!
        
        while vertQueue1.size() > 0 || vertQueue2.size() > 0{
            var node = vertQueue1.dequeue()
            
            graph.addEdge(left(node.id), f: node.id, weight: "left")
            graph.addEdge(right(node.id), f: node.id, weight: "right")
            graph.addEdge(up(node.id), f: node.id, weight: "up")
            graph.addEdge(down(node.id), f: node.id, weight: "down")
            graph.addEdge(rotateLeft(node.id), f: node.id, weight: "rotate left")
            graph.addEdge(rotateRight(node.id), f: node.id, weight: "rotate right")
            for i in node.getConnections().keys{
                var nbr = graph.vertList[i]
                var i: String? = ""
                i = nbr?.id
                frounteer1[i!] = nbr
                if frounteer2[i!] != nil{
                    var before = nbr?.pre
                    transverseFromStart(before, next: nbr!)
                    transverseFromEnd(node, next: nbr!)
                    
                    println("done")
                    return
                }
                if nbr?.color == "white"{
                    nbr?.color = "grey"
                    nbr?.distance = node.distance + 1
                    nbr?.pre = node
                    vertQueue1.enquque(nbr!)
                }
            }
            node.color = "black"
            
            node = vertQueue2.dequeue()
            
            graph.addEdge(left(node.id), f: node.id, weight: "left")
            graph.addEdge(right(node.id), f: node.id, weight: "right")
            graph.addEdge(up(node.id), f: node.id, weight: "up")
            graph.addEdge(down(node.id), f: node.id, weight: "down")
            graph.addEdge(rotateLeft(node.id), f: node.id, weight: "rotate left")
            graph.addEdge(rotateRight(node.id), f: node.id, weight: "rotate right")
            for i in node.getConnections().keys{
                var nbr = graph.vertList[i]
                var i: String? = ""
                i = nbr?.id
                frounteer2[i!] = nbr
                if frounteer1[i!] != nil{
                    transverseFromStart(node, next: nbr!)
                    var before = nbr?.pre
                    transverseFromEnd(before!, next: nbr!)
                    
                    println("done")
                    return
                }
                if nbr?.color == "white"{
                    nbr?.color = "grey"
                    nbr?.distance = node.distance + 1
                    nbr?.pre = node
                    vertQueue2.enquque(nbr!)
                }
            }
            node.color = "black"
        }
    }
    
    func transverseFromStart(node: Vertex?, next: Vertex){
        if node == nil || node?.id == next.id{
            return
        }
        var pre = node?.pre
        if pre != nil && node?.id != next.id{
            transverseFromStart(pre!, next: node!)
        }
        
        println((node?.getWeight(next.id)!)!)
    }
    
    func transverseFromEnd(node: Vertex?, next: Vertex){
        var opposites = ["left": "right", "right": "left", "up": "down", "down": "up", "rotate left": "rotate right", "rotate right": "rotate left"]
        println((opposites[node!.getWeight(next.id)!]!))
        var pre = node?.pre
        
        if pre != nil && node?.id != next.id{
            transverseFromEnd(pre!, next: node!)
        }
    }
    
    func left(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[0][0] = cube[3][0]
        temp2[0][1] = cube[3][1]
        temp2[1][0] = cube[0][0]
        temp2[1][1] = cube[0][1]
        temp2[2][0] = cube[1][0]
        temp2[2][1] = cube[1][1]
        temp2[3][0] = cube[2][0]
        temp2[3][1] = cube[2][1]
        
        temp2[4][0] = cube[4][2]
        temp2[4][1] = cube[4][0]
        temp2[4][2] = cube[4][3]
        temp2[4][3] = cube[4][1]
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }
    
    func right(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[0][0] = cube[1][0]
        temp2[0][1] = cube[1][1]
        temp2[1][0] = cube[2][0]
        temp2[1][1] = cube[2][1]
        temp2[2][0] = cube[3][0]
        temp2[2][1] = cube[3][1]
        temp2[3][0] = cube[0][0]
        temp2[3][1] = cube[0][1]
        
        temp2[4][0] = cube[4][1]
        temp2[4][1] = cube[4][3]
        temp2[4][2] = cube[4][0]
        temp2[4][3] = cube[4][2]
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }
    
    func up(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[0][0] = cube[5][0]
        temp2[0][2] = cube[5][2]
        temp2[4][0] = cube[0][0]
        temp2[4][2] = cube[0][2]
        temp2[2][3] = cube[4][0]
        temp2[2][1] = cube[4][2]
        temp2[5][0] = cube[2][3]
        temp2[5][2] = cube[2][1]
        
        temp2[1][0] = cube[1][1]
        temp2[1][1] = cube[1][3]
        temp2[1][2] = cube[1][0]
        temp2[1][3] = cube[1][2]
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }
    
    func down(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[0][0] = cube[4][0]
        temp2[0][2] = cube[4][2]
        temp2[4][0] = cube[2][3]
        temp2[4][2] = cube[2][1]
        temp2[2][3] = cube[5][0]
        temp2[2][1] = cube[5][2]
        temp2[5][0] = cube[0][0]
        temp2[5][2] = cube[0][2]
        
        temp2[1][0] = cube[1][2]
        temp2[1][1] = cube[1][0]
        temp2[1][2] = cube[1][3]
        temp2[1][3] = cube[1][1]
        
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }
    
    func rotateLeft(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[1][3] = cube[4][2]
        temp2[1][1] = cube[4][3]
        temp2[5][0] = cube[1][1]
        temp2[5][1] = cube[1][3]
        temp2[3][2] = cube[5][0]
        temp2[3][0] = cube[5][1]
        temp2[4][2] = cube[3][0]
        temp2[4][3] = cube[3][2]
        
        temp2[0][0] = cube[0][1]
        temp2[0][1] = cube[0][3]
        temp2[0][2] = cube[0][0]
        temp2[0][3] = cube[0][2]
        
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }
    
    func rotateRight(id: String) -> String{
        var count = 0
        var temp = [Character]()
        var cube = [[Character]]()
        for i in id{
            if count == 4{
                cube.append(temp)
                temp = []
                count = 0
            }
            temp.append(i)
            count += 1
        }
        cube.append(temp)
        
        var temp2 = cube
        
        temp2[4][2] = cube[1][3]
        temp2[4][3] = cube[1][1]
        temp2[3][0] = cube[4][2]
        temp2[3][2] = cube[4][3]
        temp2[5][1] = cube[3][0]
        temp2[5][0] = cube[3][2]
        temp2[1][1] = cube[5][0]
        temp2[1][3] = cube[5][1]
        
        temp2[0][0] = cube[0][2]
        temp2[0][1] = cube[0][0]
        temp2[0][2] = cube[0][3]
        temp2[0][3] = cube[0][1]
        
        
        var string = ""
        for i in temp2{
            for x in i{
                string += String(x)
            }
        }
        return string
    }

    
}