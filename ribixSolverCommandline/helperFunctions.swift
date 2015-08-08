//
//  helperFunctions.swift
//  ribixSolverCommandline
//
//  Created by Charlie Snell on 7/3/15.
//  Copyright (c) 2015 sea_software. All rights reserved.
//

import Foundation

func getln() -> String {
    let stdin = NSFileHandle.fileHandleWithStandardInput()
    var input = NSString(data: stdin.availableData, encoding: NSUTF8StringEncoding)
    input = input!.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    return input as! String
}

func promptUser(prompt: String) -> String{
    println(prompt)
    return getln()
}

func run2x2x2Cube(cube: Rubix2x2x2){
    cube.solveCube()
}

func solve2x2x2(){
    let newCube = Rubix2x2x2(startCube: promptUser("Enter the current cube state"))
    run2x2x2Cube(newCube)
}

func run3x3x3Cube(cube: Rubix3x3x3){
    cube.solveCube()
}

func solve3x3x3(){
    let newCube = Rubix3x3x3(startCube: promptUser("Enter the current cube state"))
    run3x3x3Cube(newCube)
}

func randomizeCube3x3x3(moves: Int){
    let currentCube = Rubix3x3x3(startCube: "rrrrrrrrrbbbbbbbbbooooooooogggggggggyyyyyyyyywwwwwwwww")
    for i in 0..<moves{
        let move = arc4random_uniform(12)
        switch(move){
        case 0:
            currentCube.startCube = currentCube.backLeft(currentCube.startCube)
        case 1:
            currentCube.startCube = currentCube.backRight(currentCube.startCube)
        case 2:
            currentCube.startCube = currentCube.frountLeft(currentCube.startCube)
        case 3:
            currentCube.startCube = currentCube.frountRight(currentCube.startCube)
        case 4:
            currentCube.startCube = currentCube.leftUp(currentCube.startCube)
        case 5:
            currentCube.startCube = currentCube.leftDown(currentCube.startCube)
        case 6:
            currentCube.startCube = currentCube.rightUp(currentCube.startCube)
        case 7:
            currentCube.startCube = currentCube.rightDown(currentCube.startCube)
        case 8:
            currentCube.startCube = currentCube.topLeft(currentCube.startCube)
        case 9:
            currentCube.startCube = currentCube.topRight(currentCube.startCube)
        case 10:
            currentCube.startCube = currentCube.bottomLeft(currentCube.startCube)
        case 11:
            currentCube.startCube = currentCube.bottomRight(currentCube.startCube)
        default:
            println("error")
        }
    }
    currentCube.endCube = currentCube.getFinalPos()
    currentCube.solveCube()
}