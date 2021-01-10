//
//  PagingScrollView.swift
//  UICollection
//
//  Created by Tei on 13/12/20.
//

import SwiftUI

struct PagingScrollView: View {
    
    var items = [Color.red, Color.blue, Color.green, Color.gray, Color.orange, Color.pink]
    
    @State private var isDragging = false
    @State private var index: Int = 0
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(0..<self.items.count, id: \.self) { i in
                            items[i]
                                .frame(width: geometry.size.width)
                        }
                    }
                }
                .content.offset(x: (self.isDragging ? self.offset : -geometry.size.width * CGFloat(self.index)))
                .frame(width: geometry.size.width, alignment: .leading)
                .highPriorityGesture(DragGesture()
                                        .onChanged({ value in
                                            self.isDragging = true
                                            self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                                        })
                                        .onEnded({ value in
                                            if abs(value.predictedEndTranslation.width) >= geometry.size.width / 2 {
                                                var nextIndex: Int = (value.predictedEndTranslation.width < 0) ? 1 : -1
                                                nextIndex += self.index
                                                self.index = max(min(nextIndex, items.count - 1), 0)
                                            }
                                            withAnimation {
                                                self.isDragging = false
                                            }
                                        })
                )
                // Page Indicator
                HStack {
                    ForEach(0..<self.items.count) { i in
                        if self.index == i {
                            Color.red
                                .frame(width: 20, height: 2)
                        } else {
                            Color.gray
                                .frame(width: 20, height: 2)
                        }
                    }
                }
                .padding(.vertical, 8)
            }
        }
    }
}

struct PagingScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PagingScrollView()
    }
}
