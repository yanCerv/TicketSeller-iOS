//
//  CheckoutView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 23/10/25.
//

import SwiftUI

struct CheckoutView: View {
  @EnvironmentObject var navigation: MoviesNavigation
  @State var viewModel: CheckoutViewModel
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 16) {
        HeaderCheckoutView(viewModel: viewModel)
          .padding()
        
        Divider()
        
        Section(header: Text("Información del comprador")) {
          VStack(alignment: .leading, spacing: 12) {
            TextField("Nombre(s)", text: Binding(
              get: { String(viewModel.firstName.prefix(16)) },
              set: { viewModel.firstName = String($0.prefix(16)) }
            ))
            .modifier(CheckoutTextFieldModifier(isValid: viewModel.isFirstNameValid, contentType: .givenName))
            
            TextField("Apellido(s)", text: Binding(
              get: { String(viewModel.lastName.prefix(16)) },
              set: { viewModel.lastName = String($0.prefix(16)) }
            ))
            .modifier(CheckoutTextFieldModifier(isValid: viewModel.isLastNameValid))
            
            TextField("Correo electrónico", text: Binding(
              get: { String(viewModel.email.prefix(20)) },
              set: { viewModel.email = String($0.prefix(20)) }
            ))
            .modifier(CheckoutTextFieldModifier(isValid: viewModel.isEmailValid, contentType: .emailAddress, autocapitalization: .never))
            .autocorrectionDisabled()
            .keyboardType(.emailAddress)
          }
          .padding(.vertical, 8)
          .padding(.horizontal, 24)
        }
        
        Divider()
        HStack {
          Text("Total a apagar:")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.callout)
          Text(viewModel.price)
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
        Divider()
        
        Text("Método de pago")
          .font(.headline)
          .padding(.horizontal, 24)
        
        LazyHStack(spacing: 5) {
          ForEach(viewModel.payMethodList, id: \.self) { method in
            Button(action: {
              viewModel.didSelect(payMethod: method)
            }) {
              Image(method.imageName)
                .resizable()
                .scaledToFit()
            }
            .disabled(!method.isActive || !viewModel.isFormValid)
            .frame(width: 90, height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
              RoundedRectangle(cornerRadius: 10)
                .strokeBorder(viewModel.selectedPayMethod?.id ?? "" == method.id ? Color.green : Color.gray.opacity(0.4), lineWidth: 1)
            }
          }
        }
        .padding()
      }
      .padding(.horizontal)
      .task {
        await viewModel.fetchPayMethodList()
      }
      .sheet(item: $viewModel.viewType) { _ in
        if let viewType = viewModel.viewType {
          switch viewType {
          case .card:
            CardFormView(viewModel: $viewModel)
              .presentationDetents([.fraction(0.45)])
          case .purchase:
            PurchaseView(viewModel: PurchaseViewModel(dataPurchase: viewModel.dataPurchase,
                                                      checkoutInput: viewModel))
          }
        }
      }
    }
    .overlay {
      if viewModel.isLoading {
        ProgressLoadingView(typeLoading: .movies, text: "Procesando compra...")
      }
    }
  }
}
