//
//  ContentView.swift
//  MLProgramUsingIrisData
//
//  Created by Waseem Wani on 14/11/20.
//  Copyright © 2020 Waseem Wani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sepalLength: String = ""
    @State private var sepalWidth: String = ""
    @State private var petalLength: String = ""
    @State private var petalWidth: String = ""
    
    @State private var showAlert = false
    
    @State var species = ""
    
    var body: some View {
        Form {
            Section {
                Text("Please enter the following parameters")
            }
            Section {
                TextField("sepal length", text: $sepalLength)
                TextField("sepal width", text: $sepalWidth)
                TextField("petal length", text: $petalLength)
                TextField("petal width", text: $petalWidth)
            }
            Section {
                Button(action: findSpecies) {
                    Text("Find species")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Iris species"), message: Text("It belongs to \(species)"), dismissButton: .none)
        }
    }
    
    func findSpecies() {
        let model = IrisSpeciesFinder()
        guard let sepalLen = Double(sepalLength), let sepalWd = Double(sepalWidth), let petalLen = Double(petalLength), let petalWd = Double(petalWidth) else { return }
        do {
            let prediction = try model.prediction(SepalLengthCm: sepalLen, SepalWidthCm: sepalWd, PetalLengthCm: petalLen, PetalWidthCm: petalWd)
            if prediction.Species <= 1.0 {
                species = "Iris-setosa"
            } else if prediction.Species >= 1.0 && prediction.Species <= 2.0 {
                species = "Iris-versicolor"
            } else {
                species = "Iris-virginica"
            }
            self.showAlert = true
        }
        catch {
            print("Unable to predict species")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
