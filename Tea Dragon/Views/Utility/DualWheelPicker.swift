import SwiftUI

struct DualWheelPicker: UIViewRepresentable {
    @Binding var timePeriod: TimePeriod
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.delegate = context.coordinator
        picker.dataSource = context.coordinator
        return picker
    }
    
    func updateUIView(_ uiView: UIPickerView, context: Context) {
        uiView.selectRow(timePeriod.minutes, inComponent: 0, animated: true)
        uiView.selectRow(timePeriod.seconds, inComponent: 1, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        let parent: DualWheelPicker
        
        init(_ parent: DualWheelPicker) {
            self.parent = parent
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 2 // Two wheels
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return 60 // 0-59 for minutes and seconds
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if component == 0 {
                return "\(row) min"
            } else {
                return "\(row) sec"
            }
        }
        
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return 100 // Set a smaller width for each wheel
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if component == 0 {
                parent.timePeriod.minutes = row
            } else if component == 1 {
                parent.timePeriod.seconds = row
            }
            
            // Prevent 0 minutes and 0 seconds simultaneously
            if parent.timePeriod.minutes == 0 && parent.timePeriod.seconds == 0 {
                if component == 0 {
                    // If minutes changed to 0, set seconds to 1
                    pickerView.selectRow(1, inComponent: 1, animated: true)
                    parent.timePeriod.seconds = 1
                } else if component == 1 {
                    // If seconds changed to 0, set minutes to 1
                    pickerView.selectRow(1, inComponent: 0, animated: true)
                    parent.timePeriod.minutes = 1
                }
            }
        }
    }
}
