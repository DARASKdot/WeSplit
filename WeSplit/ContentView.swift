
import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    //@Stateは状態の変化に応じてビューを再構成する
    @State private var selectedStudent = "Harry"
    
    @State var tapCount = 0
    @State private var name = ""
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    //通常classやenumで定義されるインスタンスメソッドはインスタンスを作成しないと使えない
    let greeter = Greet()
    
    @State var greetingText = ""
    
    var body: some View {
        //画面遷移や階層構造のためのView
        NavigationView {
            //ユーザーの入力させるフォームなどに適したコンポーネント
            Form {
                //ListやForm内のコンテンツのグループ化の区切りに使う。Groupは論理的なまとまりの集合に使う
                Section {
                    Group {
//                        Button("Tap Count: \(tapCount)") {
//                            self.tapCount += 1
//                        }
                        TextField("Enter your name", text: $name)
                        Text("Your Name is \(name)")
                    }
                    
//                    Group {
//                        Button("Greeting Button") {
//                            greetingText = greeter.greet(name: name)
//                        }
//                        Text(greetingText)
//                    }
                }
                
                Section {
                    Picker("Select your student", selection: $selectedStudent) {
                        ForEach(students, id: \.self) { students in
                            Text(students)
                        }
                    }
                }
                
                //省略記法
//                Section {
//                    Picker("Select your student", selection: $selectedStudent) {
//                        ForEach(students, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
//                Section {
//                    //古い記述方法。??はデフォルト値を表す。
////                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//
//                    //最新の記述方法。currencyはnilの場合があるため?が必要
//                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                    }

//                Section {
//                    //checkAmountの表示のみ
//                    Text(checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
//                }
                
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)

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
                } header: {
                    Text("How much tip do you want to leave?")
                }
            }
        }.navigationTitle("WeSplit")
    }
}

class Greet {
    func greet(name: String) -> String {
        return "Hello, \(name)!"
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

