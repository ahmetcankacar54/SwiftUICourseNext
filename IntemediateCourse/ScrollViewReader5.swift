//
//  ScrollViewReader5.swift
//  IntemediateCourse
//
//  Created by Ahmet Kaçar on 23.03.2024.
//

import SwiftUI
struct ScrollViewReader5: View {
    
    @State var indexTextFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter an item numero to go: ", text: $indexTextFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            ScrollView {
                
                // This is usually used for chat like apps
                // Becuse when user click the chat dow want to see top of the message
                // View scrolled to last message
                // So ScrollViewReader is a great choice for whatsapp like app
                ScrollViewReader { proxy in
                    
                    Button("go to the item".uppercased(), action: {
                        withAnimation(.spring()) {
                            guard let index = Int(indexTextFieldText) else {
                                return
                            }
                            scrollToIndex = index
                        }
                    })
                    
                    ForEach(0..<50) { index in
                        Text("This is the item numero #\(index)")
                            .font(.title2)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
    }
}

struct ScrollViewReader5_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReader5()
    }
}
