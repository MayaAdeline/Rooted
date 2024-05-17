//
//  UserModel.swift
//  Rooted
//
//  Created by Christopher Woods on 4/18/24.
//

import Foundation
import SpriteKit





@MainActor class User: ObservableObject{
    @Published var myTasks: [Task]
    @Published var completedTasksAmount: Int
    @Published var completedTasks: [Task]
    @Published var completedPlants: [[Task]]
    @Published var onBoarding: Bool
    
    init(){
        
        if let data = UserDefaults.standard.data(forKey: "SavedTasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            myTasks = decoded
        } else {
            myTasks = []
        }
        if let savedAmount = UserDefaults.standard.value(forKey: "SavedAmount") as? Int{
            completedTasksAmount = savedAmount
        }
        else{
            completedTasksAmount = 0
        }
        
        if let data = UserDefaults.standard.data(forKey: "CompletedTasks"),
           let decoded = try? JSONDecoder().decode([Task].self, from: data) {
            completedTasks = decoded
        } else {
            completedTasks = []
        }
        if let data = UserDefaults.standard.data(forKey: "CompletedPlants"),
           let decoded = try? JSONDecoder().decode([[Task]].self, from: data) {
            completedPlants = decoded
            
        } else {
            completedPlants = []
        }
        if let isOnboard = UserDefaults.standard.value(forKey: "onBoard") as? Bool{
            onBoarding = isOnboard
        }
        else{
            onBoarding = false
        }
        
        
        
    }
    func save(){
        if let encoded = try? JSONEncoder().encode(myTasks){
            UserDefaults.standard.set(encoded, forKey: "SavedTasks")
        }
        if let encoded = try? JSONEncoder().encode(completedTasks){
            UserDefaults.standard.set(encoded, forKey: "CompletedTasks")
        }
        if let encoded = try? JSONEncoder().encode(completedPlants){
            UserDefaults.standard.set(encoded, forKey: "CompletedPlants")
            
        }
        
        UserDefaults.standard.set(completedTasksAmount, forKey: "SavedAmount")
        UserDefaults.standard.set(onBoarding, forKey: "onBoard")

    }
    func toggle(_ user: User){
        objectWillChange.send()
        save()
    }
   
    
}


struct Task: Codable, Hashable{
    var id = UUID()
    var name: String
    var bio: String
    var type: Int
}

class RainFall: SKScene{
    override func sceneDidLoad() {
        
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill
        backgroundColor = .clear
        
        anchorPoint = CGPoint(x: 0.5, y: 1)
            
        
        let node = SKEmitterNode(fileNamed: "Rain.sks")!
        addChild(node)
        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
    
}
