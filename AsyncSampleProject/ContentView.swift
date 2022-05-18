//
//  ContentView.swift
//  AsyncSampleProject
//
//  Created by Takenouchi-Chikato on 2022/05/18.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        VStack {
            Text(viewModel.title)
                .padding()
            Button("await asyncなボタン") {
                viewModel.didTapButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
