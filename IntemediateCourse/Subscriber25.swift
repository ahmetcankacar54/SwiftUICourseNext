//
//  Subscriber25.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 4.04.2024.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count: Int = 0
    // If we have bunch of publisher, instead of creating cancellable for every publisher.
    // We simply set a list of publishers and save into them. Whenever needed we use therm.
    // Something like generic Cancellar
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid: Bool = false
    @Published var showButton: Bool = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    
    
    
    func addTextFieldSubscriber() {
        
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { text -> Bool in
                
                if text.count > 3 {
                    return true
                }
                return false
            }
        // We should not use adding method becuse we cannot use weak self
//            .assign(to: \.textIsValid, on: self)
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(
                every: 1,
                on: .main,
                in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                self.count += 1
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
                }
            }
            .store(in: &cancellables)
    }
    
}

struct Subscriber25: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    
    var body: some View {
        VStack (spacing: 20) {
            Text("\(vm.count)")
                .font(.title)
            
            
            TextField("Type Something", text: $vm.textFieldText)
                .padding()
                .frame(height: 55)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(vm.textIsValid ? .green : vm.textFieldText.count == 0 ? .gray.opacity(0.0) : .red , lineWidth: 2)
                }
                .animation(.default, value: vm.textFieldText.count == 0)
                .animation(.default, value: vm.textIsValid)
            
            Button(action: {
                
            }, label: {
                Text("submit".uppercased())
                    .foregroundColor(Color.white)
                    .font(.headline)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(vm.showButton ? 1.0 : 0.5)
            })
            .disabled(!vm.showButton)
        }
        .padding()
        
    }
}

struct Subscriber25_Previews: PreviewProvider {
    static var previews: some View {
        Subscriber25()
    }
}
