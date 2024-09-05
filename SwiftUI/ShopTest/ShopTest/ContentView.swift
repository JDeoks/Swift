//
//  ContentView.swift
//  ShopTest
//
//  Created by JDeoks on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            ForEach(<#T##data: RandomAccessCollection##RandomAccessCollection#>, id: <#T##KeyPath<RandomAccessCollection.Element, Hashable>#>, content: <#T##(RandomAccessCollection.Element) -> TableRowContent#>)
        }
        HStack {
            Image(systemName: "globe")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .foregroundStyle(.tint)
                .background(.gray)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("시원한 수박")
                        .font(.system(size: 20, weight: .bold))
                    Text("아이들이 너무나 좋아하는 시원하고 달콤한 수박이에요.")
                }
                Spacer()
                HStack{
                    Text("W 3,500")
                    Spacer()
                    HStack{
                        Image(systemName: "heart")
                        Image(systemName: "cart")
                    }
                    Spacer()
                        .frame(width: 12)
                }
                
            }
        }
        .frame(height: 100)
    }
}

#Preview {
    ContentView()
}
