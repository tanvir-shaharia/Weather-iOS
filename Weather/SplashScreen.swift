//
//  SplashScreen.swift
//  Weather
//
//  Created by MD Tanvir Shaharia on 22/2/24.
//

import SwiftUI

struct SplashScreen: View {
    @Binding var isActive: Bool

    var body: some View {
        NavigationView {
            ZStack{
                LinearGradient(
                            gradient: Gradient(colors: [Color.red, Color.blue]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .edgesIgnoringSafeArea(.all)
                VStack{
                Text("Weather App")
                        .font(.system(size: 50))
                        .bold()
                        .foregroundColor(.white)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                // Set isActive to true after 2 seconds to trigger NavigationLink
                                isActive = true
                        }
                    }
                    Text("Get your Weather correctly")
                        .padding(.top,2)
                        .foregroundColor(.white)
                        .font(.headline)
                }
            }
        }
        
    }
}
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(isActive: .constant(false))
    }
}


