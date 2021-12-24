//
//  TaskDelegate.swift
//  Time Visualizer
//
//  Created by administrator on 23/12/2021.
//

import Foundation

protocol TaskDelegate {
    
    func taskSaved(by controller: CustomTableViewCell, withTasks tasks:[EventEntity])
}
