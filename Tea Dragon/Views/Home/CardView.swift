import SwiftUI

struct CardView : View {
    @Binding var brew: Brew
    @Binding var selectedCup: Cup
    
    var body: some View {
        let usedCup = selectedCup == .automaticCup ? brew.cup : selectedCup
        let neccesarySpoons = brew.spoons.adaptToCup(originalCup: brew.cup, newCup: usedCup)
        HStack {
//            Image(systemName: "cup.and.heat.waves.fill").resizable()
//                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                Text(brew.teaName)
                    .font(.title)
                Label("\(brew.temperature.formatted())", systemImage: Icon.temperature)
                Label("\(brew.brewTimes.count) brews", systemImage: Icon.brewAmount)
                withAnimation {
                    Label("\(usedCup.info)", systemImage: Icon.cup)
                }
                Label("\(neccesarySpoons.formatted())", systemImage: Icon.spoons)
            }
        }
        .padding()
        .foregroundColor(brew.theme.accentColor)
    }
}

#Preview {
    CardView(brew: .constant(Brew.sampleData[0]), selectedCup: .constant(Brew.sampleData[0].cup))
}
