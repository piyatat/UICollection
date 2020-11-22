//
//  StretchyHeader.swift
//  UICollection
//
//  Created by Tei on 22/11/20.
//

import SwiftUI

struct StretchyHeader: View {
    
    @State private var showHeader = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 8) {
                        // Stretchy Header
                        // Ref: https://blckbirds.com/post/stretchy-header-and-parallax-scrolling-in-swiftui/
                        GeometryReader { gHeader in
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                                // Image
                                Image("Test")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: (gHeader.frame(in: .global).minY > 0 ? gHeader.size.height + gHeader.frame(in: .global).minY : gHeader.size.height))
                                    .offset(y: (gHeader.frame(in: .global).minY > 0 ? -gHeader.frame(in: .global).minY : 0))
                            }
                            .preference(key: ViewOffsetKey.self, value: CGPoint(x: gHeader.frame(in: .global).minX, y: gHeader.frame(in: .global).minY))
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .onPreferenceChange(ViewOffsetKey.self) { offset in
                            if offset.y < -geometry.size.width {
                                withAnimation() {
                                    self.showHeader = true
                                }
                            } else {
                                withAnimation() {
                                    self.showHeader = false
                                }
                            }
                        }
                        
                        VStack(alignment: .center) {
                            Text("Hello World!!!")
                            Spacer()
                        }
                        .frame(minHeight: geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom)
                    }
                }
                .frame(width: geometry.size.width, alignment: .top)
                
                if self.showHeader {
                    // Header
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Title")
                            .foregroundColor(.white)
                            .padding(.top, geometry.safeAreaInsets.top)
                        Spacer()
                    }
                    .background(Color.black)
                    .edgesIgnoringSafeArea(.top)
                    .frame(width: geometry.size.width, height: 40 + geometry.safeAreaInsets.top)
                }
            }
            .frame(width: geometry.size.width + geometry.safeAreaInsets.leading + geometry.safeAreaInsets.trailing, height: geometry.size.height + geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom, alignment: .top)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct StretchyHeader_Previews: PreviewProvider {
    static var previews: some View {
        StretchyHeader()
    }
}


struct ViewOffsetKey: PreferenceKey {
    static var defaultValue = CGPoint.zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
