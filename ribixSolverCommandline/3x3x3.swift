//
//  3x3x3.swift
//  rubixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

class Rubix3x3x3{
    var startCube: String
    var endCube: String
    init(startCube: String){
        self.startCube = startCube
        self.endCube = ""
        self.endCube = self.getFinalPos()
    }
    
    func getFinalPos() -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in self.startCube{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        
        var string = ""
        for x in 0..<6{
            for i in 0..<9{
                string += String(cube[x][1][1])
            }
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
            
            graph.addEdge(frountLeft(node.id), f: node.id, weight: "frount left")
            graph.addEdge(backRight(node.id), f: node.id, weight: "back right")
            graph.addEdge(leftUp(node.id), f: node.id, weight: "left up")
            graph.addEdge(leftDown(node.id), f: node.id, weight: "left down")
            graph.addEdge(bottomLeft(node.id), f: node.id, weight: "bottom left")
            graph.addEdge(bottomRight(node.id), f: node.id, weight: "bottom right")
            graph.addEdge(frountRight(node.id), f: node.id, weight: "frount right")
            graph.addEdge(backLeft(node.id), f: node.id, weight: "back left")
            graph.addEdge(rightUp(node.id), f: node.id, weight: "right up")
            graph.addEdge(rightDown(node.id), f: node.id, weight: "right down")
            graph.addEdge(topLeft(node.id), f: node.id, weight: "top left")
            graph.addEdge(topRight(node.id), f: node.id, weight: "top right")
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
            
            graph.addEdge(frountLeft(node.id), f: node.id, weight: "frount left")
            graph.addEdge(backRight(node.id), f: node.id, weight: "back right")
            graph.addEdge(leftUp(node.id), f: node.id, weight: "left up")
            graph.addEdge(leftDown(node.id), f: node.id, weight: "left down")
            graph.addEdge(bottomLeft(node.id), f: node.id, weight: "bottom left")
            graph.addEdge(bottomRight(node.id), f: node.id, weight: "bottom right")
            graph.addEdge(frountRight(node.id), f: node.id, weight: "frount right")
            graph.addEdge(backLeft(node.id), f: node.id, weight: "back left")
            graph.addEdge(rightUp(node.id), f: node.id, weight: "right up")
            graph.addEdge(rightDown(node.id), f: node.id, weight: "right down")
            graph.addEdge(topLeft(node.id), f: node.id, weight: "top left")
            graph.addEdge(topRight(node.id), f: node.id, weight: "top right")
            
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
    
    func leftUp(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][0] = cube[0][0][0]
        tempCube[4][1][0] = cube[0][1][0]
        tempCube[4][2][0] = cube[0][2][0]
        
        tempCube[2][0][2] = cube[4][0][0]
        tempCube[2][1][2] = cube[4][1][0]
        tempCube[2][2][2] = cube[4][2][0]
        
        tempCube[5][2][0] = cube[2][0][2]
        tempCube[5][1][0] = cube[2][1][2]
        tempCube[5][0][0] = cube[2][2][2]
        
        tempCube[0][0][0] = cube[5][0][0]
        tempCube[0][1][0] = cube[5][1][0]
        tempCube[0][2][0] = cube[5][2][0]
        
        tempCube[1][0][0] = cube[1][0][2]
        tempCube[1][0][1] = cube[1][1][2]
        tempCube[1][0][2] = cube[1][2][2]
        
        tempCube[1][1][0] = cube[1][0][1]
        tempCube[1][1][1] = cube[1][1][1]
        tempCube[1][1][2] = cube[1][2][1]
        
        tempCube[1][2][0] = cube[1][0][0]
        tempCube[1][2][1] = cube[1][1][0]
        tempCube[1][2][2] = cube[1][2][0]
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func rightUp(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][2] = cube[0][0][2]
        tempCube[4][1][2] = cube[0][1][2]
        tempCube[4][2][2] = cube[0][2][2]
        
        tempCube[2][0][0] = cube[4][0][2]
        tempCube[2][1][0] = cube[4][1][2]
        tempCube[2][2][0] = cube[4][2][2]
        
        tempCube[5][2][2] = cube[2][0][0]
        tempCube[5][1][2] = cube[2][1][0]
        tempCube[5][0][2] = cube[2][2][0]
        
        tempCube[0][0][2] = cube[5][0][2]
        tempCube[0][1][2] = cube[5][1][2]
        tempCube[0][2][2] = cube[5][2][2]
        
        tempCube[3][0][0] = cube[3][2][0]
        tempCube[3][0][1] = cube[3][1][0]
        tempCube[3][0][2] = cube[3][0][0]
        
        tempCube[3][1][0] = cube[3][2][1]
        tempCube[3][1][1] = cube[3][1][1]
        tempCube[3][1][2] = cube[3][0][1]
        
        tempCube[3][2][0] = cube[3][2][2]
        tempCube[3][2][1] = cube[3][1][2]
        tempCube[3][2][2] = cube[3][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func leftDown(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][0] = cube[2][2][2]
        tempCube[4][1][0] = cube[2][1][2]
        tempCube[4][2][0] = cube[2][0][2]
        
        tempCube[2][0][2] = cube[5][2][0]
        tempCube[2][1][2] = cube[5][1][0]
        tempCube[2][2][2] = cube[5][0][0]
        
        tempCube[5][2][0] = cube[0][2][0]
        tempCube[5][1][0] = cube[0][1][0]
        tempCube[5][0][0] = cube[0][0][0]
        
        tempCube[0][0][0] = cube[4][0][0]
        tempCube[0][1][0] = cube[4][1][0]
        tempCube[0][2][0] = cube[4][2][0]
        
        tempCube[1][0][0] = cube[1][2][0]
        tempCube[1][0][1] = cube[1][1][0]
        tempCube[1][0][2] = cube[1][0][0]
        
        tempCube[1][1][0] = cube[1][2][1]
        tempCube[1][1][1] = cube[1][1][1]
        tempCube[1][1][2] = cube[1][0][1]
        
        tempCube[1][2][0] = cube[1][2][2]
        tempCube[1][2][1] = cube[1][1][2]
        tempCube[1][2][2] = cube[1][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func rightDown(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][2] = cube[2][2][0]
        tempCube[4][1][2] = cube[2][1][0]
        tempCube[4][2][2] = cube[2][0][0]
        
        tempCube[2][0][0] = cube[5][2][2]
        tempCube[2][1][0] = cube[5][1][2]
        tempCube[2][2][0] = cube[5][0][2]
        
        tempCube[5][2][2] = cube[0][2][2]
        tempCube[5][1][2] = cube[0][1][2]
        tempCube[5][0][2] = cube[0][0][2]
        
        tempCube[0][0][2] = cube[4][0][2]
        tempCube[0][1][2] = cube[4][1][2]
        tempCube[0][2][2] = cube[4][2][2]
        
        tempCube[3][0][0] = cube[3][0][2]
        tempCube[3][0][1] = cube[3][1][2]
        tempCube[3][0][2] = cube[3][2][2]
        
        tempCube[3][1][0] = cube[3][0][1]
        tempCube[3][1][1] = cube[3][1][1]
        tempCube[3][1][2] = cube[3][2][1]
        
        tempCube[3][2][0] = cube[3][0][0]
        tempCube[3][2][1] = cube[3][1][0]
        tempCube[3][2][2] = cube[3][2][0]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func topLeft(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[0][0][0] = cube[3][0][0]
        tempCube[0][0][1] = cube[3][0][1]
        tempCube[0][0][2] = cube[3][0][2]
        
        tempCube[1][0][0] = cube[0][0][0]
        tempCube[1][0][1] = cube[0][0][1]
        tempCube[1][0][2] = cube[0][0][2]
        
        tempCube[2][0][0] = cube[1][0][0]
        tempCube[2][0][1] = cube[1][0][1]
        tempCube[2][0][2] = cube[1][0][2]
        
        tempCube[3][0][0] = cube[2][0][0]
        tempCube[3][0][1] = cube[2][0][1]
        tempCube[3][0][2] = cube[2][0][2]
        
        tempCube[4][0][0] = cube[4][2][0]
        tempCube[4][0][1] = cube[4][1][0]
        tempCube[4][0][2] = cube[4][0][0]
        
        tempCube[4][1][0] = cube[4][2][1]
        tempCube[4][1][1] = cube[4][1][1]
        tempCube[4][1][2] = cube[4][0][1]
        
        tempCube[4][2][0] = cube[4][2][2]
        tempCube[4][2][1] = cube[4][1][2]
        tempCube[4][2][2] = cube[4][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func topRight(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[0][0][0] = cube[1][0][0]
        tempCube[0][0][1] = cube[1][0][1]
        tempCube[0][0][2] = cube[1][0][2]
        
        tempCube[1][0][0] = cube[2][0][0]
        tempCube[1][0][1] = cube[2][0][1]
        tempCube[1][0][2] = cube[2][0][2]
        
        tempCube[2][0][0] = cube[3][0][0]
        tempCube[2][0][1] = cube[3][0][1]
        tempCube[2][0][2] = cube[3][0][2]
        
        tempCube[3][0][0] = cube[0][0][0]
        tempCube[3][0][1] = cube[0][0][1]
        tempCube[3][0][2] = cube[0][0][2]
        
        tempCube[4][0][0] = cube[4][0][2]
        tempCube[4][0][1] = cube[4][1][2]
        tempCube[4][0][2] = cube[4][2][2]
        
        tempCube[4][1][0] = cube[4][0][1]
        tempCube[4][1][1] = cube[4][1][1]
        tempCube[4][1][2] = cube[4][2][1]
        
        tempCube[4][2][0] = cube[4][0][0]
        tempCube[4][2][1] = cube[4][1][0]
        tempCube[4][2][2] = cube[4][2][0]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func bottomLeft(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[0][2][0] = cube[3][2][0]
        tempCube[0][2][1] = cube[3][2][1]
        tempCube[0][2][2] = cube[3][2][2]
        
        tempCube[1][2][0] = cube[0][2][0]
        tempCube[1][2][1] = cube[0][2][1]
        tempCube[1][2][2] = cube[0][2][2]
        
        tempCube[2][2][0] = cube[1][2][0]
        tempCube[2][2][1] = cube[1][2][1]
        tempCube[2][2][2] = cube[1][2][2]
        
        tempCube[3][2][0] = cube[2][2][0]
        tempCube[3][2][1] = cube[2][2][1]
        tempCube[3][2][2] = cube[2][2][2]
        
        tempCube[5][0][0] = cube[5][0][2]
        tempCube[5][0][1] = cube[5][1][2]
        tempCube[5][0][2] = cube[5][2][2]
        
        tempCube[5][1][0] = cube[5][0][1]
        tempCube[5][1][1] = cube[5][1][1]
        tempCube[5][1][2] = cube[5][2][1]
        
        tempCube[5][2][0] = cube[5][0][0]
        tempCube[5][2][1] = cube[5][1][0]
        tempCube[5][2][2] = cube[5][2][0]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func bottomRight(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[0][2][0] = cube[1][2][0]
        tempCube[0][2][1] = cube[1][2][1]
        tempCube[0][2][2] = cube[1][2][2]
        
        tempCube[1][2][0] = cube[2][2][0]
        tempCube[1][2][1] = cube[2][2][1]
        tempCube[1][2][2] = cube[2][2][2]
        
        tempCube[2][2][0] = cube[3][2][0]
        tempCube[2][2][1] = cube[3][2][1]
        tempCube[2][2][2] = cube[3][2][2]
        
        tempCube[3][2][0] = cube[0][2][0]
        tempCube[3][2][1] = cube[0][2][1]
        tempCube[3][2][2] = cube[0][2][2]
        
        tempCube[5][0][0] = cube[5][2][0]
        tempCube[5][0][1] = cube[5][1][0]
        tempCube[5][0][2] = cube[5][0][0]
        
        tempCube[5][1][0] = cube[5][2][1]
        tempCube[5][1][1] = cube[5][1][1]
        tempCube[5][1][2] = cube[5][0][1]
        
        tempCube[5][2][0] = cube[5][2][2]
        tempCube[5][2][1] = cube[5][1][2]
        tempCube[5][2][2] = cube[5][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func frountRight(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][2][0] = cube[1][2][2]
        tempCube[4][2][1] = cube[1][1][2]
        tempCube[4][2][2] = cube[1][0][2]
        
        tempCube[1][0][2] = cube[5][0][0]
        tempCube[1][1][2] = cube[5][0][1]
        tempCube[1][2][2] = cube[5][0][2]
        
        tempCube[5][0][0] = cube[3][2][0]
        tempCube[5][0][1] = cube[3][1][0]
        tempCube[5][0][2] = cube[3][0][0]
        
        tempCube[3][0][0] = cube[4][2][0]
        tempCube[3][1][0] = cube[4][2][1]
        tempCube[3][2][0] = cube[4][2][2]
        
        tempCube[0][0][0] = cube[0][2][0]
        tempCube[0][0][1] = cube[0][1][0]
        tempCube[0][0][2] = cube[0][0][0]
        
        tempCube[0][1][0] = cube[0][2][1]
        tempCube[0][1][1] = cube[0][1][1]
        tempCube[0][1][2] = cube[0][0][1]
        
        tempCube[0][2][0] = cube[0][2][2]
        tempCube[0][2][1] = cube[0][1][2]
        tempCube[0][2][2] = cube[0][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    
    func frountLeft(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][2][0] = cube[3][0][0]
        tempCube[4][2][1] = cube[3][1][0]
        tempCube[4][2][2] = cube[3][2][0]
        
        tempCube[1][0][2] = cube[4][2][2]
        tempCube[1][1][2] = cube[4][2][1]
        tempCube[1][2][2] = cube[4][2][0]
        
        tempCube[5][0][0] = cube[1][2][2]
        tempCube[5][0][1] = cube[1][1][2]
        tempCube[5][0][2] = cube[1][0][2]
        
        tempCube[3][0][0] = cube[5][0][2]
        tempCube[3][1][0] = cube[5][0][1]
        tempCube[3][2][0] = cube[5][0][0]
        
        tempCube[0][0][0] = cube[0][0][2]
        tempCube[0][0][1] = cube[0][1][2]
        tempCube[0][0][2] = cube[0][2][2]
        
        tempCube[0][1][0] = cube[0][0][1]
        tempCube[0][1][1] = cube[0][1][1]
        tempCube[0][1][2] = cube[0][2][1]
        
        tempCube[0][2][0] = cube[0][0][0]
        tempCube[0][2][1] = cube[0][1][0]
        tempCube[0][2][2] = cube[0][2][0]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func backRight(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][0] = cube[1][2][0]
        tempCube[4][0][1] = cube[1][1][0]
        tempCube[4][0][2] = cube[1][0][0]
        
        tempCube[1][0][0] = cube[5][2][0]
        tempCube[1][1][0] = cube[5][2][1]
        tempCube[1][2][0] = cube[5][2][2]
        
        tempCube[5][2][0] = cube[3][2][2]
        tempCube[5][2][1] = cube[3][1][2]
        tempCube[5][2][2] = cube[3][0][2]
        
        tempCube[3][0][2] = cube[4][0][0]
        tempCube[3][1][2] = cube[4][0][1]
        tempCube[3][2][2] = cube[4][0][2]
        
        tempCube[2][0][0] = cube[2][0][2]
        tempCube[2][0][1] = cube[2][1][2]
        tempCube[2][0][2] = cube[2][2][2]
        
        tempCube[2][1][0] = cube[2][0][1]
        tempCube[2][1][1] = cube[2][1][1]
        tempCube[2][1][2] = cube[2][2][1]
        
        tempCube[2][2][0] = cube[2][0][0]
        tempCube[2][2][1] = cube[2][1][0]
        tempCube[2][2][2] = cube[2][2][0]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
    }
    
    func backLeft(id: String) -> String{
        var count = 0
        var count2 = 0
        var temp = [Character]()
        var temp2 = [[Character]]()
        var cube = [[[Character]]]()
        for i in id{
            if count == 3{
                temp2.append(temp)
                temp = []
                count = 0
                count2 += 1
            }
            if count2 == 3{
                cube.append(temp2)
                temp2 = []
                count2 = 0
            }
            temp.append(i)
            count += 1
        }
        temp2.append(temp)
        cube.append(temp2)
        var tempCube = cube
        
        tempCube[4][0][0] = cube[3][0][2]
        tempCube[4][0][1] = cube[3][1][2]
        tempCube[4][0][2] = cube[3][2][2]
        
        tempCube[1][0][0] = cube[4][0][2]
        tempCube[1][1][0] = cube[4][0][1]
        tempCube[1][2][0] = cube[4][0][0]
        
        tempCube[5][2][0] = cube[1][0][0]
        tempCube[5][2][1] = cube[1][1][0]
        tempCube[5][2][2] = cube[1][2][0]
        
        tempCube[3][0][2] = cube[5][2][2]
        tempCube[3][1][2] = cube[5][2][1]
        tempCube[3][2][2] = cube[5][2][0]
        
        tempCube[2][0][0] = cube[2][2][0]
        tempCube[2][0][1] = cube[2][1][0]
        tempCube[2][0][2] = cube[2][0][0]
        
        tempCube[2][1][0] = cube[2][2][1]
        tempCube[2][1][1] = cube[2][1][1]
        tempCube[2][1][2] = cube[2][0][1]
        
        tempCube[2][2][0] = cube[2][2][2]
        tempCube[2][2][1] = cube[2][1][2]
        tempCube[2][2][2] = cube[2][0][2]
        
        
        var string = ""
        
        for i in tempCube{
            for x in i{
                for y in x{
                    string += String(y)
                }
            }
        }
        return string
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
        var opposites = ["top left": "top right", "top right": "top left", "bottom left": "bottom right", "bottom right": "bottom left", "left up": "left down", "left down": "left up", "right up": "right down", "right down": "right up", "frount left": "frount right", "frount right": "frount left", "back right": "back left", "back left": "back right"]
        println((opposites[node!.getWeight(next.id)!]!))
        var pre = node?.pre
        
        if pre != nil && node?.id != next.id{
            transverseFromEnd(pre!, next: node!)
        }
    }

}