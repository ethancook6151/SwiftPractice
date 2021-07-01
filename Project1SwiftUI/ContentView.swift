//
//  ContentView.swift
//  Project1SwiftUI
//
//  Created by Ethan Cook on 6/30/21.
//
// 19:35 min into https://www.youtube.com/watch?v=VGJBLlfSN-Y&t=2s
// Problems are at line 46-50

import Combine
import SwiftUI

class DataSource: ObservableObject {
    let didChange = PassthroughSubject<Void, Never>()
    var pictures = [String]()
    
    init() {
        let fm = FileManager.default
        
        if let path = Bundle.main.resourcePath, let items = try? fm.contentsOfDirectory(atPath: path) {
            for item in items {
                if item.hasPrefix("nssl") {
                    pictures.append(item)
                }
            }
        }
        didChange.send(())
    }
        
}

struct DetailView: View {
    var selectedImage: String
    
    var body: some View {
        Image(selectedImage)
    }
}


struct ContentView: View {
    @ObservedObject var dataSource = DataSource()
    
    var body: some View {
        NavigationView {
            List(dataSource.pictures.identified(by: \.self)) { picture in
                UIBarButtonItem {
                    Text(picture)
                }
            } .navigationTitle(Text("Storm Viewer"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
