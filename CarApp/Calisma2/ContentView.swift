//
//  ContentView.swift
//  Calisma2
//
//  Created by Yiğit Özok on 16.12.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack(spacing:20){
                ScrollView{
                    HomeHeader()
                    CustomDivider()
                    CarSection()
                    CustomDivider()
                    CategoryView(title:"Quick ShortCuts",showEdit: true,actionItems: quickShortcuts)
                    //actionItems bizde dizi istiyor.
                    CustomDivider()
                    CategoryView(title:"Recent Actions",showEdit: true,actionItems: recentActions)
                    CustomDivider()
                    AllSettings(settingsItems: SettingsItems)
               
                }.padding()
            }
            VoiceCommandButton()
        }
        .frame(width: .infinity,height:.infinity)
        .background(Color("Dark Gray"))
        .foregroundColor(Color.white)//ön plan rengi
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
struct VoiceCommandButton : View{
    var body : some View{
        ZStack{
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Image(systemName: "mic.fill")
                        .font(.system(size: 24,weight: .semibold,design: .default))
                        .frame(width: 64,height: 64)
                        .background(Color("Green"))
                        .foregroundColor(Color("Dark Gray"))
                        .clipShape(Circle())
                        .padding()//Görsel nesne ile çerçevere arasına default      şekilde boşluk bırakır.
                        .shadow(radius: 10)
                }
            }.edgesIgnoringSafeArea(.all)//Safe arenın dışarı çıkmasına yarıyor.
        }
    }
}
struct HomeHeader : View{
    var body : some View{
        HStack{
            VStack(alignment: .leading,spacing: 10){
                Text("Model 3".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)//font ağırlığı
                    .frame(width:100,height: 30)
                    .background(Color("Red"))
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                Text("Mach Five")
                    .font(.largeTitle)
                    .fontWeight(.semibold)//yarı koyun
            }
            Spacer()
            Button(action:{}){
                GeneralButton(icon: "lock")
            }
            Button(action:{}){
                GeneralButton(icon: "gear")
            }
            
        }
        .padding(.top)
    }
}
struct GeneralButton: View{
    var icon: String
    var body: some View{
        Image(systemName:icon)
            .imageScale(.large)//Görsel nesnenin içindeki görseli büyütüyor.
            .frame(width: 44,height: 44)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white.opacity(0.05)))//görselin etrafına border eklememize yarar
    }
}
struct CustomDivider : View{
    var body: some View{
            Rectangle()
            .frame(width: .infinity,height: 0.5)
            .background(Color.white)
            .opacity(0.1)
    }
}
struct CarSection : View{
    var body: some View{
        VStack{
            HStack(){
                HStack(alignment:.center){
                    Image(systemName: "battery.75")
                    Text("237 Miles".uppercased())
            
                }
                .font(.system(size: 14,weight: .semibold,design: .rounded))
                .foregroundColor(Color.green)
                Spacer()
                VStack(alignment:.trailing){
                    Text("Parked")
                        .fontWeight(.semibold)
                    Text("Last updated: 5 min ago")
                        .font(.caption2)
                        .foregroundColor(Color.gray)
                }
            }
            Image("Car1")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct CategoryHeader : View{
    var title : String
    var showEdit : Bool = false
    
    var body: some View{
            HStack(alignment:.center){ // Text'ler arasındaki font farklı.
                Text(title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                if showEdit {
                    Button(action:{}){
                        Text("Edit")
                            .foregroundColor(Color.gray)
                            .fontWeight(.medium)
                    }
                }
            }
    }
}
struct CategoryView : View{
    var title : String
    var showEdit : Bool = false
    var actionItems : [ActionItem] // quickShortcuts  veya recentActions yolluyoruz.
    
    var body: some View{
        
        VStack{
            CategoryHeader(title:title,showEdit: showEdit)
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment:.top){
                    
                    ForEach(actionItems,id:\.self){item in
                        ActionButtom(item:item)
        
                    }
                }
            }
        }
    }
}
struct ActionButtom : View{
    
    var item : ActionItem
    
    var body: some View{
        VStack(alignment:.center){
            GeneralButton(icon:item.icon)
            Text(item.text)
                //Text Bazında , ActionButtom'ıza ait özelliklerin olması.
                .frame(width: 72)
                .font(.system(size: 12,weight: .semibold,design: .default))
                .multilineTextAlignment(.center)//text'leri hizalama
        }
    }
}
struct ActionItem : Hashable{
        var icon : String
        var text : String
}
let quickShortcuts : [ActionItem] = [
    ActionItem(icon: "bolt.fill", text: "Charging"),ActionItem(icon: "fanblades.fill", text: "Fan On"),ActionItem(icon: "music.note", text: "Media Control"),ActionItem(icon: "bolt.car", text: "Close Change Port")]
let recentActions : [ActionItem] = [
    ActionItem(icon: "arrow.up.square", text: "Open Truck"),ActionItem(icon: "fanblades", text: "Fan Off"),ActionItem(icon: "person.fill.viewfinder", text: "Summon")]


struct AllSettings : View{
    var settingsItems : [SettingItem]
    
    var body: some View{
        VStack{
            CategoryHeader(title: "All Settings")
            LazyVGrid(columns: [GridItem(.fixed(170)),GridItem(.fixed(170))]){
                ForEach(settingsItems,id: \.self) { item in
                    SettingsButtom(item: item)
                }
            }
        }
    }
}
struct SettingsButtom : View{
    
    var item: SettingItem
    
    var body: some View{
        HStack(alignment: .center,spacing: 2){
                Image(systemName: item.icon)
                VStack(alignment: .leading, spacing: 4){
                    Text(item.text)
                        .font(.system(size: 16, weight:.semibold ,design:.default))
                    Text(item.subText.uppercased())
                        .font(.system(size: 8,weight: .medium))
                        .lineLimit(1)
                }
                .padding(.leading,5)
                Spacer()
                Image(systemName: "chevron.right")
                
                
        }
        .padding(.horizontal,8)
        .padding(.vertical,16)
        .background(item.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius:16).stroke(Color.white.opacity(0.05)))
    }
}
struct SettingItem : Hashable{
    var icon : String
    var text : String
    var subText : String
    var backgroundColor : Color = Color.white.opacity(0.05)
    
}
let SettingsItems : [SettingItem] = [
    SettingItem(icon: "car.fill", text: "Controls",subText: "Car Loclked"),
    SettingItem(icon: "fanblades.fill", text: "Climate",subText: "Interior 68F",backgroundColor:Color.blue),
    SettingItem(icon: "location.fill", text: "Location",subText: "Empire State Building"),
    SettingItem(icon: "checkerboard.shield", text: "Security",subText: "0 events detected"),
    SettingItem(icon: "sparkles", text: "Uprades",subText: "3 uprades available")]
