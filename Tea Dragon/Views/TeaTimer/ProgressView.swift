import SwiftUI

struct InteractiveProgressBar<TitleContent: View, SubtitleContent: View>: View {
    @State private var isInteracting: Bool = false // Tracks interaction state
    let title: TitleContent
    let subtitle: SubtitleContent
    @Binding var currentTime: TimePeriod
//    @State private var localCurrentTime: TimePeriod = .init(milliseconds: 0)
    var totalTime: TimePeriod
    var hasPrevious: Bool
    @Binding var isPlaying: Bool
    var hasNext: Bool
    var previousAction: (()->Void)?
    var nextAction: (()->Void)?
    var playAction: (()->Void)?
    var pauseAction: (()->Void)?
    

    var body: some View {
        var progress: Double {
            get {
                return Double(currentTime.total_milliseconds) / Double(totalTime.total_milliseconds)
            }
            set {
                currentTime.total_milliseconds = Int(newValue * Double(totalTime.total_milliseconds))
            }
        }
        
        VStack {
            // Time labels
            HStack {
                VStack {
                    HStack {
                        title
                        Spacer()
                    }
                    HStack {
                        subtitle
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            
            // Playback controls
            HStack {
                Button(action: {
                    previousAction?()
                }) {
                    Image(systemName: "backward.fill")
                }
                .disabled(!hasPrevious)
                Spacer()
                if isPlaying {
                    Button(action: {
                        pauseAction?()
                    }) {
                        Image(systemName: "pause.fill")
                    }
                } else {
                    Button(action: {
                        playAction?()
                    }) {
                        Image(systemName: "play.fill")
                    }
                }
                Spacer()
                Button(action: {
                    nextAction?()
                }) {
                    Image(systemName: "forward.fill")
                }
                .disabled(!hasNext)
            }
            .padding(.horizontal)
            .font(Font.system(size: 40))
            .padding()
            .padding(.bottom)

            // Interactive progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    Capsule()
                        .fill(Color.secondary.opacity(0.3))
                        .frame(height: isInteracting ? 12 : 8) // Thickness increases when interacting

                    // Progress fill
                    Capsule()
                        .fill(Color.accentColor)
                        .frame(width: CGFloat(progress) * geometry.size.width, height: isInteracting ? 12 : 8)
                        .animation(.easeInOut(duration: 0.2), value: progress)
                }
                .frame(height: 8)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            isInteracting = true
                            let location = value.location.x / geometry.size.width
                            progress = max(0, min(1, Double(location))) // Clamp between 0 and 1
                        }
                        .onEnded { _ in
                            isInteracting = false
                        }
                )
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isInteracting)
            }
            .frame(height: 20)
            .padding(.horizontal)
            
            HStack {
                Text(currentTime.formatTime()) // Start time
                Spacer()
                Text(totalTime.formatTime()) // Total duration
            }
            .padding(.horizontal)

            
        }
        .padding()
    }
}

struct PlayerControlTestView: View {
    @StateObject var teaTimer: TeaTimer = TeaTimer()
    var timePeriod: TimePeriod
    
    var body: some View {
        InteractiveProgressBar(title: Text("We Two"), subtitle: Text("Aimer"), currentTime: $teaTimer.timeElapsed, totalTime: teaTimer.totalTime, hasPrevious: false, isPlaying: .constant(false), hasNext: false)
            .onAppear {
                teaTimer.stop()
                teaTimer.reset(timePeriod: timePeriod)
                teaTimer.start()
            }
    }
}

#Preview {
    let total: TimePeriod = TimePeriod(minutes: 4, seconds: 30)
    PlayerControlTestView(timePeriod: total)
}
