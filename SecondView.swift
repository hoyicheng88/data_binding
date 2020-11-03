//
//  SecondView.swift
//  data_binding
//
//  Created by User19 on 2020/11/3.
//

import SwiftUI

struct SecondView: View {
    
    @Binding  var music:Bool
    @Binding  var name:String
    @Binding  var selectDate:Date
    @Binding  var pickindex:Int
    @Binding  var wordSize: Double
    @Binding  var Counter: Int
    @Binding  var state :Int
    @Binding  var score :Int
    var position=["大砲","欄中","副攻","舉球","自由球員"]
    var background=["日向翔陽","西谷夕","木兔光太郎","烏野","影山飛雄"]
    var Score=["-25","-24","-23","-22","-21","-20","-19","-18","-17","-16","-15","-14","-13","-12","-11","-10","-9","-8","-7","-6","-5","-4","-3","-2","-1","0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25"]
    @State private var show = false
    @State private var snackTime = Date()
    @State private var showingSheet = false
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    var body: some View {
        VStack{
            Music(music: $music, state: $state)
            Spacer()
            VStack{
                
                if show{
                    TextView(text:"對手:"+name+"\n得分差:"+String(Score[score]+""))
                        .font(.system(size:CGFloat(wordSize)))
                        .foregroundColor(Color.orange)
                        .transition(.opacity)
                        .contextMenu {
                            Button(action: {
                                self.show=false
                            }) {
                                HStack {
                                    Text("刪除")
                                    Image(systemName: "trash.fill")
                                }
                            }
                            Button(action: {
                            }) {
                                HStack {
                                    Text("取消")
                                    Image(systemName: "trash.slash")
                                }
                            }
                    }
                    TextView(text: "位置:\t"+position[pickindex]+"\n日期:\t"+dateFormatter.string(from: selectDate))
                        .font(.system(size:CGFloat(wordSize)))
                        .font(.footnote)
                        .foregroundColor(Color.orange)
                        .transition(.opacity)
                        .contextMenu {
                            Button(action: {
                                self.show=false
                            }) {
                                HStack {
                                    Text("Disappear!")
                                    Image(systemName: "trash.fill")
                                }
                            }
                            Button(action: {
                            }) {
                                HStack {
                                    Text("Nothing happened")
                                    Image(systemName: "trash.slash")
                                }
                            }
                    }
                }
            }.animation(.easeInOut(duration:3))
                .onAppear {
                    self.show = true
                    
            }
            .onDisappear {
                self.show = false
            }
            
            Spacer()
            Button(action: {
                self.showingSheet = true
                self.show=true
            }) {
                Text("一直輸球嗎？:((")
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(30)
            }
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(title: Text("練球啊！！"), message: Text("還敢不練球啊？")
                                , buttons: [.default(Text("我很抱歉..."))])
            }
            
        }.background(Image(background[Counter]).resizable().scaledToFill())
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(music: .constant(true), name: .constant("Chapter1~2"), selectDate: .constant(Date()), pickindex: .constant(2), wordSize: .constant(25), Counter: .constant(5), state: .constant(0),score:.constant(25))
    }
}

struct TextView: View {
    var text:String
    var body: some View {
        Text(text)
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(30)
            //.font
    }
}
