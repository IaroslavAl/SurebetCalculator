//
//  ContentView.swift
//  SureBet Calculator
//
//  Created by Iaroslav Beldin on 21.01.2023.
//

//
//  ContentView.swift
//  SureBet Calculator
//
//  Created by Iaroslav Beldin on 21.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    // модификатор
    struct ModifierGeneral: ViewModifier {
        let width: CGFloat?
        let height: CGFloat?
        
        func body(content: Content) -> some View {
            content
                .padding()
                .frame(width: width, height: height)
                .background(.gray.opacity(0.15))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                .keyboardType(.decimalPad)
        }
    }
    
    @FocusState var isFocused: Bool
    
    // isOn переключатели: 0 - Total amount; 1 - Odd1; 2 - Odd2; 3 - Odd3; 4 - Odd4
    @State var isOnToggles = [true, false, false, false, false]
    
    // textField ввод суммы ставки: 0 - Total amount; 1 - Stake1; 2 - Stake2; 3 - Stake3; 4 - Stake4
    @State var textFieldStakes = ["", "", "", "", ""]
    
    // textField ввод КФ: 1 - Odd1; 2 - Odd2; 3 - Odd3; 4 - Odd4
    @State var textFieldOdds = ["", "", "", ""]
    
    // пикер
    @State var selectedOdds = 0
    
    // тело
    var body: some View {
        VStack {
            Text("SureBet Profit Calculator")
                .font(.title)
                .padding()
            
            Picker("Odds", selection: $selectedOdds) {
                Text("2 Odds").tag(0)
                Text("3 Odds").tag(1)
                Text("4 Odds").tag(2)
            }
            .pickerStyle(.segmented)
            
            ScrollView {
                // 2 Odds
                if selectedOdds == 0 || selectedOdds == 1 || selectedOdds == 2 {
                    HStack(alignment: .bottom) {
                        Image(systemName: isOnToggles[0] ? "record.circle" : "circle")
                            .padding()
                            .frame(width: 30, height: 50)
                            .foregroundColor(isOnToggles[0] ? Color.green : Color.red)
                            .onTapGesture {
                                isOnToggles = [true, false, false, false, false]
                            }
                        
                        VStack {
                            Text("Total amount")
                            if isOnToggles[0] {
                                TextField("Type here...", text: $textFieldStakes[0])
                                    .modifier(ModifierGeneral(width: 165, height: 50))
                                    .focused($isFocused)
                            } else {
                                Text("\(result[0], specifier: "%.2f")")
                                    .modifier(ModifierGeneral(width: 165, height: 50))
                            }
                        }
                        
                        VStack {
                            Text("Profit")
                            Text("\(result[1], specifier: "%.2f") %")
                                .modifier(ModifierGeneral(width: 165, height: 50))
                                .foregroundColor(result[1] > 0 ? .green : .red)
                        }
                    }
                    .padding(.top)
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: isOnToggles[1] ? "record.circle" : "circle")
                            .padding()
                            .frame(width: 30, height: 50)
                            .foregroundColor(isOnToggles[1] ? Color.green : Color.red)
                            .onTapGesture {
                                isOnToggles = [false, true, false, false, false]
                                //                            textFieldStakes = ["", "", "", "", ""]
                            }
                        
                        VStack {
                            Text("Odds")
                            TextField("1", text: $textFieldOdds[0])
                                .modifier(ModifierGeneral(width: 77, height: 50))
                                .focused($isFocused)
                                .toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            isFocused = false
                                        }
                                    }
                                }
                        }
                        
                        VStack{
                            Text("Stake")
                            if isOnToggles[1] {
                                TextField("Stake 1", text: $textFieldStakes[1])
                                    .modifier(ModifierGeneral(width: 122, height: 50))
                                    .focused($isFocused)
                            } else {
                                Text("\(result[2], specifier: "%.2f")")
                                    .modifier(ModifierGeneral(width: 122, height: 50))
                            }
                        }
                        
                        VStack{
                            Text("Winning")
                            Text("\(result[3], specifier: "%.2f")")
                                .modifier(ModifierGeneral(width: 122, height: 50))
                                .foregroundColor(result[3] > 0 ? .green : .red)
                        }
                    }
                    .padding(.top)
                    
                    HStack(alignment: .bottom) {
                        Image(systemName: isOnToggles[2] ? "record.circle" : "circle")
                            .padding()
                            .frame(width: 30, height: 50)
                            .foregroundColor(isOnToggles[2] ? Color.green : Color.red)
                            .onTapGesture {
                                isOnToggles = [false, false, true, false, false]
                                //                            textFieldStakes = ["", "", "", "", ""]
                            }
                        
                        TextField("2", text: $textFieldOdds[1])
                            .modifier(ModifierGeneral(width: 77, height: 50))
                            .focused($isFocused)
                        
                        if isOnToggles[2] {
                            TextField("Stake 2", text: $textFieldStakes[2])
                                .modifier(ModifierGeneral(width: 122, height: 50))
                                .focused($isFocused)
                        } else {
                            Text("\(result[4], specifier: "%.2f")")
                                .modifier(ModifierGeneral(width: 122, height: 50))
                        }
                        
                        Text("\(result[5], specifier: "%.2f")")
                            .modifier(ModifierGeneral(width: 122, height: 50))
                            .foregroundColor(result[5] > 0 ? .green : .red)
                    }
                }
                
                // 3 Odds
                if selectedOdds == 1 || selectedOdds == 2 {
                    HStack(alignment: .bottom) {
                        Image(systemName: isOnToggles[3] ? "record.circle" : "circle")
                            .padding()
                            .frame(width: 30, height: 50)
                            .foregroundColor(isOnToggles[3] ? Color.green : Color.red)
                            .onTapGesture {
                                isOnToggles = [false, false, false, true, false]
                                //                            textFieldStakes = ["", "", "", "", ""]
                            }
                        
                        TextField("3", text: $textFieldOdds[2])
                            .modifier(ModifierGeneral(width: 77, height: 50))
                            .focused($isFocused)
                        
                        if isOnToggles[3] {
                            TextField("Stake 3", text: $textFieldStakes[3])
                                .modifier(ModifierGeneral(width: 122, height: 50))
                                .focused($isFocused)
                        } else {
                            Text("\(result[6], specifier: "%.2f")")
                                .modifier(ModifierGeneral(width: 122, height: 50))
                        }
                        
                        Text("\(result[7], specifier: "%.2f")")
                            .modifier(ModifierGeneral(width: 122, height: 50))
                            .foregroundColor(result[7] > 0 ? .green : .red)
                    }
                }
                
                // 4 Odds
                if selectedOdds == 2 {
                    HStack(alignment: .bottom) {
                        Image(systemName: isOnToggles[4] ? "record.circle" : "circle")
                            .padding()
                            .frame(width: 30, height: 50)
                            .foregroundColor(isOnToggles[4] ? Color.green : Color.red)
                            .onTapGesture {
                                isOnToggles = [false, false, false, false, true]
                                //                            textFieldStakes = ["", "", "", "", ""]
                            }
                        
                        TextField("4", text: $textFieldOdds[3])
                            .modifier(ModifierGeneral(width: 77, height: 50))
                            .focused($isFocused)
                        
                        if isOnToggles[4] {
                            TextField("Stake 4", text: $textFieldStakes[4])
                                .modifier(ModifierGeneral(width: 122, height: 50))
                                .focused($isFocused)
                        } else {
                            Text("\(result[8], specifier: "%.2f")")
                                .modifier(ModifierGeneral(width: 122, height: 50))
                        }
                        
                        Text("\(result[9], specifier: "%.2f")")
                            .modifier(ModifierGeneral(width: 122, height: 50))
                            .foregroundColor(result[9] > 0 ? .green : .red)
                    }
                }
            }
            Spacer()
        }
    }
    
    // подсчеты
    var result: Array<Double> {
        
        // форматер массивов в Double
        func formaterArray(array: [String]) -> [Double] {
            
            // форматер десятичного разделителя
            func formater(format: String) -> Double {
                let formater = NumberFormatter()
                formater.decimalSeparator = "."
                if formater.number(from: format) != nil {
                    return formater.number(from: format) as! Double
                } else {
                    formater.decimalSeparator = ","
                    if formater.number(from: format) != nil {
                        return formater.number(from: format) as! Double
                    }
                }
                return 0
            }
            
            var arrayFormat: [Double] = []
            for index in array {
                arrayFormat.append(formater(format: index))
            }
            return arrayFormat
        }

        var textFieldStakesDouble = formaterArray(array: textFieldStakes)
        let textFieldOddsDouble = formaterArray(array: textFieldOdds)
        var winnings = [0.0, 0.0, 0.0, 0.0, 0.0]
        
        if selectedOdds == 0 {
            let sure = (1 / textFieldOddsDouble[0]) + (1 / textFieldOddsDouble[1])
            
            if isOnToggles[0] && textFieldStakesDouble[0] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 {
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[1] && textFieldStakesDouble[1] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[1] / (1 / textFieldOddsDouble[0] / sure)
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[2] && textFieldStakesDouble[2] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[2] / (1 / textFieldOddsDouble[1] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            winnings[1] = (textFieldStakesDouble[1] * textFieldOddsDouble[0]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[2] = (textFieldStakesDouble[2] * textFieldOddsDouble[1]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[3] = 0.0
            winnings[4] = 0.0
        }
        
        if selectedOdds == 1 {
            let sure = (1 / textFieldOddsDouble[0]) + (1 / textFieldOddsDouble[1]) + (1 / textFieldOddsDouble[2])
            
            if isOnToggles[0] && textFieldStakesDouble[0] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 {
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[1] && textFieldStakesDouble[1] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[1] / (1 / textFieldOddsDouble[0] / sure)
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[2] && textFieldStakesDouble[2] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[2] / (1 / textFieldOddsDouble[1] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[3] && textFieldStakesDouble[3] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[3] / (1 / textFieldOddsDouble[2] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            winnings[1] = (textFieldStakesDouble[1] * textFieldOddsDouble[0]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[2] = (textFieldStakesDouble[2] * textFieldOddsDouble[1]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[3] = (textFieldStakesDouble[3] * textFieldOddsDouble[2]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[4] = 0.0
        }
        
        if selectedOdds == 2 {
            let sure = (1 / textFieldOddsDouble[0]) + (1 / textFieldOddsDouble[1]) + (1 / textFieldOddsDouble[2]) + (1 / textFieldOddsDouble[3])
            
            if isOnToggles[0] && textFieldStakesDouble[0] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 && textFieldOddsDouble[3] > 0 {
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[4] = 1 / textFieldOddsDouble[3] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[1] && textFieldStakesDouble[1] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 && textFieldOddsDouble[3] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[1] / (1 / textFieldOddsDouble[0] / sure)
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[4] = 1 / textFieldOddsDouble[3] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[2] && textFieldStakesDouble[2] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 && textFieldOddsDouble[3] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[2] / (1 / textFieldOddsDouble[1] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[4] = 1 / textFieldOddsDouble[3] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[3] && textFieldStakesDouble[3] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 && textFieldOddsDouble[3] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[3] / (1 / textFieldOddsDouble[2] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[4] = 1 / textFieldOddsDouble[3] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            if isOnToggles[4] && textFieldStakesDouble[4] > 0 && textFieldOddsDouble[0] > 0 && textFieldOddsDouble[1] > 0 && textFieldOddsDouble[2] > 0 && textFieldOddsDouble[3] > 0 {
                textFieldStakesDouble[0] = textFieldStakesDouble[4] / (1 / textFieldOddsDouble[3] / sure)
                textFieldStakesDouble[1] = 1 / textFieldOddsDouble[0] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[2] = 1 / textFieldOddsDouble[1] / sure * textFieldStakesDouble[0]
                textFieldStakesDouble[3] = 1 / textFieldOddsDouble[2] / sure * textFieldStakesDouble[0]
                winnings[0] = (100 / sure) - 100
            }
            
            winnings[1] = (textFieldStakesDouble[1] * textFieldOddsDouble[0]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[2] = (textFieldStakesDouble[2] * textFieldOddsDouble[1]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[3] = (textFieldStakesDouble[3] * textFieldOddsDouble[2]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
            winnings[4] = (textFieldStakesDouble[4] * textFieldOddsDouble[3]) - textFieldStakesDouble[1] - textFieldStakesDouble[2] - textFieldStakesDouble[3] - textFieldStakesDouble[4]
        }
        
        let arrayResult = [textFieldStakesDouble[0], winnings[0], textFieldStakesDouble[1], winnings[1], textFieldStakesDouble[2], winnings[2], textFieldStakesDouble[3], winnings[3], textFieldStakesDouble[4], winnings[4]]
        
        return arrayResult
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
