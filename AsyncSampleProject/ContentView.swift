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
            Button("N個直列に実行するボタン") {
                viewModel.didTapSyncButton()
            }
            Button("N個並列に実行するボタン") {
                viewModel.didTapAsyncButton()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
