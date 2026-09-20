//
//  CardFormView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

struct CardFormView: View {
  @Binding var viewModel: CheckoutViewModel
  
  var body: some View {
    Form {
      Section(header: Text("Información de la tarjeta")) {
        TextField("Número de tarjeta", text: $viewModel.cardNumber)
          .keyboardType(.numberPad)
          .textContentType(.creditCardNumber)
          .padding(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(viewModel.isCardFilled ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
          )
          .onChange(of: viewModel.cardNumber) { oldValue, newValue in
            viewModel.didSet(text: newValue, from: .card)
          }
       
        TextField("Nombre en la tarjeta", text: $viewModel.cardName)
          .autocapitalization(.words)
          .padding(8)
          .overlay(
            RoundedRectangle(cornerRadius: 8)
              .stroke(viewModel.cardName.count > 3 ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
          )
          .onChange(of: viewModel.cardName) { oldValue, newValue in
            viewModel.didSet(text: newValue, from: .name)
          }

        HStack(spacing: 16) {
          TextField("MM/AA", text: $viewModel.cardDate)
            .keyboardType(.numberPad)
            .padding(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(viewModel.cardDate.count == 5 ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
            )
            .onChange(of: viewModel.cardDate) { oldValue, newValue in
              viewModel.didSet(text: newValue, from: .date)
            }

          SecureField("CVV", text: $viewModel.cardCvc)
            .keyboardType(.numberPad)
            .padding(8)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(viewModel.cardCvc.count >= 3 ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
            )
            .onChange(of: viewModel.cardCvc) { oldValue, newValue in
              viewModel.didSet(text: newValue, from: .cvc)
            }
        }
        
        
        Button("Pagar") {
          viewModel.didTapPurchase()
        }
        .modifier(ButtonModifier())
        .padding()
      }
    }
  }
}

extension String {
  func formattedExpiry(maxLength: Int = 5) -> String {
    let cleaned = self.filter(\.isNumber)
    var result = ""
    for (index, char) in cleaned.enumerated() {
      if index == 2 { result += "/" }
      if index >= maxLength { break }
      result.append(char)
    }
    return result
  }
  
  /// method for card format  0000 0000 0000 0000
  ///
  /// README PLEASE!!!!!
  ///
  /// - Returns: format with 1 space for every 4 characters
  /// - Notes: operation module 4 inside on "for cicle" validate,
  ///          current index in character using result divide with 4,
  ///          if result is 0, plus a empty value - for every 4 characters a empty space is added
  func cardStringFormat() -> String {
      let arrOfCharacters = Array(self)
      var modifiedCreditCardString = ""
      if !arrOfCharacters.isEmpty {
          for characterIndex in 0...arrOfCharacters.count - 1 {
              modifiedCreditCardString.append(arrOfCharacters[characterIndex])
              if((characterIndex + 1) % 4) == 0 && characterIndex + 1 != arrOfCharacters.count {
                  modifiedCreditCardString.append(" ")
              }
          }
      }
      return modifiedCreditCardString
  }
}
