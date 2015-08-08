//
//  Queue.swift
//  ribixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

struct Queue <T>{
    var queue = [T]()
    
    mutating func isEmpty() -> Bool{
        return count(queue) == 0
    }
    
    mutating func enquque(item: T){
        queue.insert(item, atIndex: 0)
    }
    
    mutating func dequeue() -> T{
        return queue.removeLast()
    }
    
    mutating func size() -> Int{
        return count(queue)
    }
}
