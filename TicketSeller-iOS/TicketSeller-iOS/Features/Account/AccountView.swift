//
//  AccountView.swift
//  TicketSeller-iOS
//
//  Created by Yan Cervantes on 29/10/25.
//

import SwiftUI

struct AccountView: View {
  @EnvironmentObject var navigation: AccountNavigation
  @State var viewModel: AccountViewModel
  
  var body: some View {
    NavigationStack(path: $navigation.paths) {
      ScrollView {
        VStack {
          if viewModel.isUserLoggedIn {
            
          } else {
            Button("Login / Register") {
              viewModel.didTapLoginRegister()
            }
            .modifier(ButtonModifier())
            .frame(height: 45)
            .padding(.horizontal, 26)
          }
          
          Divider()
            .background(Color.ticketDivider)
            .padding()
          
          SectionHeader(title: "Ajustes")
          
          VStack {
            Button {
              viewModel.didTapPickerCountry()
            } label: {
              Text("\(viewModel.countryFlag) País")
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.white.opacity(0.7))
                .padding()
                .background(Color.white.opacity(0.1))
                .clipShape(Capsule())
                .overlay(
                  Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
            }
            .sheet(isPresented: $viewModel.showCountryPicker) {
              PickerContent(title: "Selecciona un país", data: viewModel.countryFlags, selected: $viewModel.selectedCountry)
            }
            .sheet(isPresented: $viewModel.showLanguagePicker) {
              PickerContent(title: "Selecciona un idioma", data: viewModel.countryLanguages, selected: $viewModel.selectedLanguage)
            }
            .sheet(isPresented: $viewModel.showLoginRegister) {
              LoginRegister(viewModel: LoginRegisterViewModel())
                .presentationDetents([.fraction(0.45)])
            }
            
            Button {
              viewModel.didTapPickerLanguage()
            } label: {
              HStack {
                Image(systemName: "globe")
                  .foregroundStyle(.white.opacity(0.7))
                Text("Idioma")
                  .foregroundStyle(.white.opacity(0.7))
              }
              .frame(maxWidth: .infinity, alignment: .center)
              .padding()
              .background(Color.white.opacity(0.1))
              .clipShape(Capsule())
              .overlay(
                Capsule().stroke(Color.white.opacity(0.3), lineWidth: 1)
              )
            }
            
          }
          .padding(.horizontal, 20)
          
          Divider()
            .background(Color.ticketDivider)
            .padding()
          
          SectionHeader(title: "About")
          
          VStack {
            Text("Ticket Seller - iOS")
              .font(.system(size: 14, weight: .medium))
              .frame(maxWidth: .infinity, alignment: .center)
              .padding(.vertical, 2)
            Text(Bundle.appVersion)
              .font(.system(size: 12, weight: .medium))
              .frame(maxWidth: .infinity, alignment: .center)
              .padding(.bottom, 2)
          }
          .background(Color.brown.opacity(0.4))
          .clipShape(RoundedRectangle(cornerRadius: 6))
          .overlay(RoundedRectangle(cornerRadius: 6)
            .stroke(.clear))
          .padding()
        }
      }
      .navigationTitle("Cuenta")
      .navigationBarTitleDisplayMode(.inline)
      .task {
        await viewModel.fetchAppCountries()
      }
    }
  }
}

#Preview {
  AccountView(viewModel: AccountViewModel())
}
