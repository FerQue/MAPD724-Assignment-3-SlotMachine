//
//  SupportView.swift
//  MAPD724-Assignment-1_2_3-Slot Machine App
//
//  Created by Victor Quezada on 2023-02-21.
//

import SwiftUI

struct SupportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("jackpot_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            
            Form {
                Section(header: Text("Instructions how to play")) {
                    FormRowView(firstItem: "The User can select a BET according to the amount of money in Credits")
                    FormRowView(firstItem: "The User can select a BET of $5, $10, $100, and $500")
                    FormRowView(firstItem: "Select the button SPIN")
                    FormRowView(firstItem: "The User can win what they bet")
                    FormRowView(firstItem: "The User can lost what they bet")
                    
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.title)
            }
                .padding(.top, 5)
                .padding(.trailing, 20)
                .accentColor(Color.secondary)
            , alignment: .topTrailing
        )
        
    }
}

struct FormRowView: View {
    var firstItem: String
    var body: some View {
        HStack {
            Text(firstItem).foregroundColor(Color.gray)
        }
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}


