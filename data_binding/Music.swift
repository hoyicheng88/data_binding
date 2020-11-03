//
//  Music.swift
//  data_binding
//
//  Created by User19 on 2020/11/3.
//
import SwiftUI
import AVFoundation
import MediaPlayer

struct Music: View {
    @State var play = true
    @State var judge:Int=0
    @Binding  var music:Bool
    @Binding  var state:Int
    //@State var looper: AVPlayerLooper?
    let player = AVPlayer()
    let commandCenter = MPRemoteCommandCenter.shared()
    func musicfun(music:Bool)->String{
        var myMusic="主題曲"
        if music{
            myMusic="BGM"
        }else{
            myMusic="主題曲"
        }
        return myMusic
    }
    var body: some View {
        HStack{
            Image(self.musicfun(music: self.music))
                .resizable()
                .frame(width:50,height:50)
                .scaledToFill()
                .padding(.trailing,40)
            Text("FIGHTING!")
                .font(.system(size:22))
                .bold()
                .foregroundColor(Color.blue)
            Spacer()
            Button(action: {
                let fileUrl=Bundle.main.url(forResource:self.musicfun(music: self.music),withExtension: "mp3")
                let playerItem = AVPlayerItem(url: fileUrl!)
                //self.looper = AVPlayerLooper(player: self.player, templateItem: playerItem)
                if(self.judge != self.state){
                    //self.player.pause()
                    self.player.replaceCurrentItem(with: playerItem)
                    self.judge=self.state
                }
                self.play.toggle()
                if self.play{
                    self.player.pause()
                }
                else{
                    do {
                        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                    }
                    catch {
                        // report for an error
                    }
                    self.player.play()
                }
                self.commandCenter.playCommand.addTarget {  event in
                    if self.player.rate == 0.0 {
                        do {
                            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
                        }
                        catch {
                            // report for an error
                        }
                        self.player.play()
                        return .success
                    }
                    return .commandFailed
                }
                
                self.commandCenter.pauseCommand.addTarget {  event in
                    if self.player.rate == 1.0 {
                        self.player.pause()
                        return .success
                    }
                    return .commandFailed
                }
                
            }){
                Image(systemName: play ? "play.circle" : "pause.circle")
                    .resizable()
                    .frame(width:40,height:40)
                    .foregroundColor(Color.orange)
            }
        }
        .padding(10)
        .background(LinearGradient(gradient: Gradient(colors: [Color(red:249/255,green:245/255,blue:134/255), Color(red:150/255,green:251/255,blue:196/255)]), startPoint: UnitPoint(x: 0.4, y: 0.4), endPoint: UnitPoint(x: 1, y: 1))).opacity(0.65)
    }
}

struct Music_Previews: PreviewProvider {
    static var previews: some View {
        Music( music: .constant(false), state: .constant(0))
    }
}

