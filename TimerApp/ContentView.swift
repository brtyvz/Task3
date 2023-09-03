import SwiftUI

struct ContentView: View {
    @EnvironmentObject var timerManager: TimerManager

    var body: some View {
        VStack {
            
            if timerManager.isTimerRunning {}
            
            HStack {
                Text("Minutes:")
                Picker("Minutes", selection: $timerManager.selectedMinutes) {
                    ForEach(0..<60, id: \.self) { minute in
                        Text("\(minute)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80)

                Text("Seconds:")
                Picker("Seconds", selection: $timerManager.selectedSeconds) {
                    ForEach(0..<60, id: \.self) { second in
                        Text("\(second)")
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 80)
            }
            .padding()

            RoundedRectangle(cornerRadius: 10)
                .frame(width: 200, height: 100)
                .foregroundColor(.yellow)
                .overlay(
                    Text(timerManager.timeString)
                        .font(.largeTitle)
                )
                .padding()

            if timerManager.isTimerRunning {
                Button(action: {
                    timerManager.stopTimer()
                }) {
                    Text("Pause")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: {
                    timerManager.startTimer()
                }) {
                    Text("Play")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }

            Button(action: {
                timerManager.resetTimer()
                // Zamanlayıcı sıfırlandığında veya değiştirildiğinde
                // bu işlevi çağırarak zamanı güncelleyin.
                timerManager.updateTimerBasedOnAppCloseTime()
            }) {
                Text("Set/Reset")
                    .font(.title)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .onReceive(timerManager.$isTimerCompleted) { completed in
                if completed {
                    timerManager.sendNotification() // Zamanlayıcı tamamlandığında bildirimi gönder
                }
            }
    }
}






























//import SwiftUI
//
//struct ContentView: View {
//    @EnvironmentObject var timerManager: TimerManager
//
//    var body: some View {
//        VStack {
//            HStack {
//                Text("Minutes:")
//                Picker("Minutes", selection: $timerManager.selectedMinutes) {
//                    ForEach(0..<60, id: \.self) { minute in
//                        Text("\(minute)")
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .frame(width: 80)
//
//                Text("Seconds:")
//                Picker("Seconds", selection: $timerManager.selectedSeconds) {
//                    ForEach(0..<60, id: \.self) { second in
//                        Text("\(second)")
//                    }
//                }
//                .pickerStyle(WheelPickerStyle())
//                .frame(width: 80)
//            }
//            .padding()
//
//            RoundedRectangle(cornerRadius: 10)
//                .frame(width: 200, height: 100)
//                .foregroundColor(.yellow)
//                .overlay(
//                    Text(timerManager.timeString)
//                        .font(.largeTitle)
//                )
//                .padding()
//
//            if timerManager.isTimerRunning {
//                Button(action: {
//                    timerManager.stopTimer()
//                }) {
//                    Text("Pause")
//                        .font(.title)
//                        .padding()
//                        .background(Color.red)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            } else {
//                Button(action: {
//                    timerManager.startTimer()
//                }) {
//                    Text("Play")
//                        .font(.title)
//                        .padding()
//                        .background(Color.green)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//            }
//
//            Button(action: {
//                timerManager.resetTimer()
//            }) {
//                Text("Set/Reset")
//                    .font(.title)
//                    .padding()
//                    .background(Color.gray)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//            
//            Spacer()
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(TimerManager())
//    }
//}
