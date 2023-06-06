
import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    @FocusState private var amountIsFocused: Bool
    
    private var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
            FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currency?.identifier ?? "USD")
        }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Your Name is \(name)")
                }
                
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text("\($0) %")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyFormatter)
                    Text(totalPerPerson * Double(numberOfPeople + 2), format: currencyFormatter)
                } header: {
                    Text("Amount per person and Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
