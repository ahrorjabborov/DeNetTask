//
//  testTaskApp.swift
//  testTask
//
//  Created by Ahror Jabborov on 3/19/24.
//

import SwiftUI

@main
struct TreeApp: App {
    @StateObject private var viewModel = TreeViewModel()
    
    var body: some Scene {
        WindowGroup {
            if let rootNode = viewModel.rootNode {
                NavigationView {
                    TreeView(viewModel: viewModel, node: rootNode)
                }
            }
        }
    }
}

