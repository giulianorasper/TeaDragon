import SwiftUI

struct PlaybackControllerView<TitleContent: View, SubtitleContent: View>: View {
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
            PlaybackControls(hasPrevious: hasPrevious, hasNext: hasPrevious, isPlaying: isPlaying, previousAction: previousAction, playAction: playAction, pauseAction: pauseAction, nextAction: nextAction)
            
            ProgressBar(currentTime: $currentTime, totalTime: totalTime)
            
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
        PlaybackControllerView(title: Text("We Two"), subtitle: Text("Aimer"), currentTime: $teaTimer.timeElapsed, totalTime: teaTimer.totalTime, hasPrevious: false, isPlaying: .constant(false), hasNext: false)
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



