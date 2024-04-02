//
//  workoutTimerView.swift
//  intervalTimer
//
//  Created by Masato Nandate on 6/2/23.
//

import Foundation
import SwiftUI
import AVFoundation
import AudioToolbox

struct exerciseTimerView: View{
    @Binding var exerciseArray: [Exercise]
    @State var exerciseTimer: Int
    @State var ind =  0
    @State var audioPlayer: AVAudioPlayer?
    @State var showCircle = true
    @State var intervals: Int
    @State var mute: Bool = false
    @State var pause: Bool = false
    var circleIntervals: Int
    let systemSoundID: SystemSoundID = 1321
    //initalize the timer
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View{
            VStack{
                if(showCircle){
                    Circle()
                        .stroke(lineWidth: 10)
                        .overlay{
                            VStack{
                                HStack{
                                    Button(action: muteTimer){
                                        if(mute){
                                            Label("Un-Mute", systemImage: "speaker.slash")
                                                .labelStyle(.iconOnly)
                                                .font(.title)

                                        }
                                        else{
                                            Label("Mute", systemImage: "speaker.wave.3")
                                                .labelStyle(.iconOnly)
                                                .font(.title)
                                        }
                                    }
                                    Button(action: pauseTimer){
                                        if(!pause){
                                            Label("Pause", systemImage: "pause")
                                                .labelStyle(.iconOnly)
                                                .font(.title)
                                        }
                                        else {
                                            Label("Un-Pause", systemImage: "play")
                                                .labelStyle(.iconOnly)
                                                .font(.title)
                                        }
                                    }
                                    Button(action: nextExercise){
                                        Label("Skip", systemImage: "forward")
                                            .labelStyle(.iconOnly)
                                            .font(.title)
                                        
                                    }
                                }
                                Text(exerciseArray[ind].name)
                                    .font(.title)
                                Text(String(exerciseTimer))
                                    .bold()
                                    .font(.system(size: 30))
                                    .onReceive(timer) { time in
                                        if (intervals <= 0)
                                        {
                                            timer.upstream.connect().cancel()
                                            showCircle = false
                                        }
                                        else if (exerciseTimer > 0)
                                        {
                                            exerciseTimer -= 1
                                        }
                                        else
                                        {
                                            //Any other code that should happen after countdown
                                            exerciseTimer = 0
                                            if(!mute){
//                                                playSound()
                                                AudioServicesPlaySystemSound(systemSoundID)
                                            }
                                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                                            nextExercise()
                                        }
                                    }
                            }
                        }
                        .overlay{
                            exerciseArc(currSeconds: exerciseTimer, totalSeconds: exerciseArray[ind].lengthInSeconds, startAngle: .degrees(0), clockwise: true)
                                .stroke(exerciseArray[ind].backColor.mainColor, lineWidth: 5)
                        }.padding(.horizontal)
                    HStack{
                        ForEach(1..<circleIntervals + 1, id: \.self) {index in
                            if(index > intervals){
                                Circle()
                                    .fill(Theme.white.mainColor)
                                    .frame(width: 20, height: 20)
                            }
                            else{
                                Circle()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }.padding(20)
                }
                else{
                    Text("Good Job!")
                        .font(.title)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(exerciseArray[ind].backColor.mainColor)
        }
    
    func playSound() {
        guard let soundURL = Bundle.main.path(forResource: "xylophoneSound.mp3", ofType: nil) else {
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundURL))
            audioPlayer?.play()
        } catch {
            print("Error loading sound file: \(error.localizedDescription)")
        }
    }
    
    func muteTimer(){
        mute = !mute
    }
    
    func pauseTimer(){
        pause = !pause
        if(pause){
            timer.upstream.connect().cancel()
        }
        else{
            timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
    }
    
    func nextExercise(){
        if(ind < exerciseArray.count - 1){
            ind += 1
            exerciseTimer = exerciseArray[ind].lengthInSeconds
        }
        else{
            intervals -= 1
            ind = 0
        }
        if(intervals <= 0){
            showCircle = false
        }
    }
}


struct ExerciseTimer_Previews: PreviewProvider {
    static var previews: some View {
        exerciseTimerView(exerciseArray: .constant(Exercise.sampleDataOne), exerciseTimer: Exercise.sampleDataOne.first?.lengthInSeconds ?? 10, intervals: 5,
                      circleIntervals: 5)
    }
}
