//
//  SideMenu.swift
//  UICollection
//
//  Created by Tei on 22/11/20.
//

import SwiftUI

struct SideMenu: View {
    
    @State private var showMenu = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                NavigationView {
                    GeometryReader { gNav in
                        // Content View
                        VStack {
                            Text("Hello World!!!")
                        }
                        .frame(width: gNav.size.width + gNav.safeAreaInsets.leading + gNav.safeAreaInsets.trailing, height: gNav.size.height, alignment: .center)
                        .navigationBarTitle("Title", displayMode: .inline)
//                        .toolbar {
//                            ToolbarItem(placement: .principal) {
//                                VStack {
//                                    Text("Title").font(.headline)
//                                    Button("Subtitle") {
//
//                                    }
//                                }
//                            }
//                        }
                        .navigationBarItems(leading:
                                                HStack {
                                                    // Menu Button
                                                    Button(action: {
                                                        withAnimation {
                                                            self.showMenu = true
                                                        }
                                                    }) {
                                                        Text("Menu")
                                                    }
                                                    .buttonStyle(PlainButtonStyle())
                                                }
                        )
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .frame(width: geometry.size.width, height: geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom, alignment: .center)
                .edgesIgnoringSafeArea(.top)
                .offset(x: self.showMenu ? max(300, geometry.size.width * 0.5): 0)
                .disabled(self.showMenu)
                
                // Side Menu
                HStack(alignment: .top, spacing: 0) {
                    MenuView(showMenu: self.$showMenu)
                        .frame(width: max(300, geometry.size.width * 0.5), height: geometry.size.height)
                    if self.showMenu {
                        Spacer()
                            .frame(height: geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom)
                            .background(Color.black.opacity(0.2))
                            .onTapGesture(count: 1, perform: {
                                withAnimation {
                                    self.showMenu = false
                                }
                            })
                    }
                }
                .offset(x: self.showMenu ? 0: -(geometry.size.width + geometry.safeAreaInsets.leading + geometry.safeAreaInsets.trailing))
            }
        }
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        SideMenu()
    }
}


struct MenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Station List
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(0..<20, id: \.self) { i in
                            Button(action: {
                                withAnimation() {
                                    self.showMenu.toggle()
                                }
                            }) {
                                Text("Menu Item - \(i+1)")
                            }
                            .frame(height: 40)
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .padding(.top, geometry.safeAreaInsets.top)
            .padding(.bottom, geometry.safeAreaInsets.bottom)
        }
    }
}
