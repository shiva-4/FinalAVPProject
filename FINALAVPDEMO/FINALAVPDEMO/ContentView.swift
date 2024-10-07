import SwiftUI

struct ContentView: View {
    // State to track traffic light status
    @State private var currentLight: TrafficLight = .green
    @State private var showStopSign = true
    @State private var timerRunning = false
    @State private var countdown = 5 // Countdown timer starting from 5 seconds

    // Enum to define traffic light states
    enum TrafficLight {
        case red, yellow, green
    }

    // Timer function to count down and change the light
    func startTimer() {
        timerRunning = true
        showStopSign = false // Hidse the stop sign once the timer starts

        // A repeating timer to decrement the countdown
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate() // Stop the timer
                self.currentLight = .red // Change the traffic light to red
                self.timerRunning = false // Timer has ended
            }
        }
    }

    var body: some View {
        VStack {
            // Display the traffic light pole with three lights
            if !showStopSign {
                VStack(spacing: 20) {
                    // Red light
                    Circle()
                        .fill(currentLight == .red ? Color.red : Color.gray) // Red light
                        .frame(width: 100, height: 100)

                    // Yellow light (could be used in future transitions)
                    Circle()
                        .fill(currentLight == .yellow ? Color.yellow : Color.gray) // Yellow light
                        .frame(width: 100, height: 100)

                    // Green light
                    Circle()
                        .fill(currentLight == .green ? Color.green : Color.gray) // Green light
                        .frame(width: 100, height: 100)
                }
                .padding()
                
                // Text to show the countdown timer
                if timerRunning {
                    Text("Time left: \(countdown)")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding()
                } else {
                    Text(currentLight == .red ? "Stop" : "Go")
                        .font(.largeTitle)
                        .foregroundColor(currentLight == .red ? .red : .green)
                }
            }

            // Stop sign button, visible when the app opens or the timer is not running
            if showStopSign {
                Button(action: {
                    startTimer()
                }) {
                    Text("STOP")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: 200, height: 200)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                }
                .padding()
            }

            Spacer() // Add space between the elements and the bottom of the screen
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

