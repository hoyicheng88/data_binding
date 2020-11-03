//
//  ContentView.swift
//  binding
//
//  Created by User19 on 2020/11/3.
//
//

import SwiftUI
import MapKit


struct ContentView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.149919, longitude: 121.773315), span: MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003))
    @State private var fontcolor = Color.primary
    @State private var backcolor = Color(red: 204/255, green: 199/255, blue: 212/255)
    @State private var music = false
    @State private var showAlert = false
    @State private var name = "請輸入對手"
    @State private var selectDate = Date()
    @State private var pickindex:Int = Int.random(in: 0...4)
    @State private var wordSize: Double = Double.random(in: 25...40)
    @State private var Counter: Int = Int.random(in: 0...4)
    @State private var score : Int = Int.random(in: 0...50)
    @State private var showSecondPage = false
    @State private var state = 0
    let today = Date()
    let endDate = Calendar.current.date(byAdding: .hour, value: 3, to: Date())!
    var position=["大砲","欄中","副攻","舉球","自由球員"]
    var background=["日向翔陽","西谷夕","木兔光太郎","烏野","影山飛雄"]
    var Score=["-25","-24","-23","-22","-21","-20","-19","-18","-17","-16","-15","-14","-13","-12","-11","-10","-9","-8","-7","-6","-5","-4","-3","-2","-1","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    var body: some View {
        
        ZStack{
            //Text("比賽紀錄")
            //Spacer()
            Color(red: 228/255, green: 241/255, blue: 245/255)
            //Color.yellow.opacity(0.5)
            VStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Image("COVER")
                    .resizable()
                    .scaledToFill()
                    .frame(width:UIScreen.main.bounds.width,height:200)
                    .clipped()
                
                Form{
                    Text("比賽紀錄").fontWeight(.bold).font(.largeTitle).frame(width:305,height: 50, alignment: .center).foregroundColor(fontcolor)
                    Section{
                        TextField("本次對手", text: $name, onEditingChanged: { (editing) in
                            print("onEditingChanged", editing)
                            
                            self.showAlert = true
                        }){
                            print(self.name)
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(fontcolor)
                        .keyboardType(.default)
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.blue, lineWidth: 3))
                        .padding()
                        .alert(isPresented: $showAlert) { () -> Alert in
                            let result: String
                            if self.name.isEmpty {
                                result = "請輸入對手！"
                            } else {
                                result = self.name + ""
                            }
                            return Alert(title: Text(result))
                        }
                        Picker(selection: $pickindex, label: Text("場上位置").foregroundColor(fontcolor)) {
                            ForEach(0 ..< position.count) { i in
                                Text(self.position[i]).tag(i)
                            }
                        }
                        //.pickerStyle(InlinePickerStyle())
                        //.pickerStyle(SegmentedPickerStyle())
                        .pickerStyle(MenuPickerStyle())
                        
                        
                        
                        DatePicker("日期", selection: self.$selectDate, in:...today, displayedComponents:.date)
                            //.datePickerStyle(WheelDatePickerStyle())
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .foregroundColor(fontcolor)
                        HStack {
                            if music {
                                Image("BGM")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text("BGM").foregroundColor(fontcolor)
                                
                            } else {
                                Image("主題曲")
                                    .resizable()
                                    .frame(width: 64, height: 64)
                                Text("主題曲").foregroundColor(fontcolor)
                                
                            }
                            Toggle("音樂版本", isOn: $music).foregroundColor(fontcolor)
                        }
                        Stepper(value:self.$score,in:0...51){
                            Text("得分差")
                                .padding(.trailing)
                                .foregroundColor(fontcolor)
                            Text(Score[score])
                                .padding(.leading)
                                .foregroundColor(fontcolor)
                        }
                        DisclosureGroup("球場位置"){
                            
                            Map(coordinateRegion: $region).frame(width: 400, height: 500, alignment: .leading)
                                
                            }
                    }
                    Section{
                        Stepper(value:self.$Counter,in:0...4){
                            Text("背景圖")
                                .padding(.trailing)
                                .foregroundColor(fontcolor)
                            Text(background[Counter])
                                .padding(.leading)
                                .foregroundColor(fontcolor)
                        }
                        HStack {
                            Text("字體大小")
                                .foregroundColor(fontcolor)
                            Slider(value: self.$wordSize, in: 25...40,
                                   minimumValueLabel: Image(systemName:
                                                                "textformat.size").imageScale(.small), maximumValueLabel: Image(systemName: "textformat.size").imageScale(.large)) {
                                Text("").foregroundColor(fontcolor)
                            }
                        }
                        Text("文字大小")
                            .font(.system(size:CGFloat(wordSize)))
                            .foregroundColor(fontcolor)
                        
                        DisclosureGroup("個人化設定"){
                            VStack{
                                ColorPicker("文字顏色",selection:$fontcolor)
                                    .foregroundColor(fontcolor)
                                ColorPicker("背景顏色",selection:$backcolor)
                                    .foregroundColor(fontcolor)
                            }
                            
                        }
                        
                                                    
                        
                        
                        
                        
                        
                    }
                }
                .colorMultiply(backcolor)
                //.background(Color(red: 182/255, green: 177/255, blue: 189/255))//form
                
                
                Button("登錄") {
                    self.showSecondPage = true
                    self.state+=1
                }.sheet(isPresented: self.$showSecondPage) {
                    SecondView(music: self.$music, name: self.$name, selectDate: self.$selectDate, pickindex: self.$pickindex, wordSize: self.$wordSize, Counter:self.$Counter, state: self.$state, score:self.$score)
                }
                .padding(.bottom,20)
            }
            //.background(Color.gray)vstack
        }
        //.background(Color.gray)zstack
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
