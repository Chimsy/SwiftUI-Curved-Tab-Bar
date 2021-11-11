//
//  CustomTabBar.swift
//  SwiftUI-Curved-Tab-Bar
//
//  Created by Golden Chimusinde on 8/11/2021.
//

import SwiftUI

struct CustomTabBar: View {
    // Current Tab...
    @State var currentTab: Tab = .Home
    
    // Hiding Native One...
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    // Matched Geometry Effect
    @Namespace var animation
    
    // Current Tab XValue
    @State var currentXValue: CGFloat = 0
    
    
    var body: some View {
        
        TabView(selection: $currentTab){
            
            SampleCards(color: .purple, count: 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Home)
            
            Text("Search")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Search)
            
            Text("Notification")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Notification)
            
            Text("Setting")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG").ignoresSafeArea())
                .tag(Tab.Account)
            
        }
        
        // Curved Tab Bar..
        .overlay(
            HStack(spacing: 0){
                
                ForEach(Tab.allCases, id: \.rawValue){ tab in
                    TabButton(tab: tab)
                }
            }
                .padding(.vertical)
            // Preview Won't Show SafeArea...
                .padding(.bottom, getSafeArea().bottom == 0 ? 10 : (getSafeArea().bottom - 10))
                .background(MaterialEffect(style: .systemUltraThinMaterialDark)
                                .clipShape(BottomCurve(currentXValue: currentXValue)))
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
        //Always Dark
        .preferredColorScheme(.dark)
    }
    
    // Sample Cards...
    @ViewBuilder
    func SampleCards(color: Color, count: Int)->some View{
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(spacing: 15){
                    ForEach(1...count, id: \.self){index in
                        
                        Image("post\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                            .cornerRadius(12)
                    }
                }
                .padding()
                // Approx Bottom Padding...
                // 30 Size...
                // Padding = 30...
                // Bottom Edge...
                .padding(.bottom, 60)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            }
            .navigationTitle("Home")
        }
        
    }
    
    
    // Tab Button..
    @ViewBuilder
    func TabButton(tab: Tab)-> some View{
        
        
        // Since We Need XAxis Value for Curve...
        GeometryReader{proxy in
            Button{
                withAnimation(.spring()){
                    currentTab = tab
                    
                    // Updating Value
                    currentXValue = proxy.frame(in: .global).midX
                }
                
            }label: {
                
                // Moving Button Up For Current Tab
                Image(systemName: tab.rawValue)
                // Since we need perfect value for Curve...
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(currentTab == tab ? 15 : 0)
                    .background(
                        ZStack{
                            if currentTab == tab{
                                MaterialEffect(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            // Setting Initial Curve Position...
            .onAppear{
                if tab == Tab.allCases.first && currentXValue == 0{
                    currentXValue = proxy.frame(in: .global).midX
                    
                }
            }
        }
        .frame(height: 30)
        // MaxSize...
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
            .previewInterfaceOrientation(.portrait)
    }
}

// To Iterate...
// Enum for Tab
enum Tab: String, CaseIterable{
    case Home = "house.fill"
    case Search = "magnifyingglass"
    case Notification = "bell.fill"
    case Account = "person.fill"
    
}


extension View{
    func getSafeArea()->UIEdgeInsets{
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
    
    
}
