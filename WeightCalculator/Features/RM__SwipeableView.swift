//
//  SwipeableView.swift
//  WeightCalculator
//
//  Created by Вадим on 02.02.2025.
//

import SwiftUI

struct SwipeableView<Content: View>: View {
    
    // MARK: - Properties
    
    let slowingRate: CGFloat = 3
    let triggerRate: CGFloat = 0.4
    
    let content: () -> Content
    
    @State private var xOffset: CGFloat = 0
    @State private var startOffset: CGFloat = 0
    
    let leadingButtons: [Button<Text>]
    let trailingButtons: [Button<Text>] 
    
    @State private var leadingButtonsSize = CGSize.zero
    @State private var trailingButtonsSize = CGSize.zero
    
    @State private var isLeadingButtonsHidden = true
    @State private var isTrailingButtonsHidden = true
    
    // MARK: - Body
    
    var body: some View {
        
        ZStack {
            
            /// Leading actions
            HStack {
                self.hidden(self.isLeadingButtonsHidden) {
                    self.buttonsStack(buttons: self.leadingButtons)
                        .getSize { size in
                            self.leadingButtonsSize = size
                        }                    
                }
                Spacer()
            }
            
            /// Trailing actions
            HStack {
                Spacer()
                self.hidden(self.isTrailingButtonsHidden) {
                    self.buttonsStack(buttons: self.trailingButtons)
                        .getSize { size in
                            self.trailingButtonsSize = size
                        }
                }
            }
            
            /// Main content
            self.content()
                .offset(x: self.xOffset)
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { value in
                            
                            var offset: CGFloat
                            
                            /// Check if the offset is from the initial point
                            if self.startOffset == 0 {
                                /// Detect the offset direction
                                if value.translation.width > 0 {
                                    offset = self.onDragStart(value.translation.width, buttonsWidth: self.leadingButtonsSize.width)
                                    self.isLeadingButtonsHidden = false
                                    self.isTrailingButtonsHidden = true
                                } else {
                                    offset = self.onDragStart(value.translation.width, buttonsWidth: self.trailingButtonsSize.width)
                                    self.isLeadingButtonsHidden = true
                                    self.isTrailingButtonsHidden = false
                                }
                            } else {
                                offset = self.onDragResume(value.translation.width)
                            }
                            
                            self.xOffset = offset
                            
                        }
                        .onEnded { value in
                            
                            /// Check if the trigger has been crossed for the transition to the target offset position
                            if value.translation.width > self.leadingButtonsSize.width * self.triggerRate {
                                self.onDragEnd(value.translation.width, buttonsWidth: self.leadingButtonsSize.width)
                            } else if value.translation.width < -self.trailingButtonsSize.width * self.triggerRate {
                                self.onDragEnd(value.translation.width, buttonsWidth: self.trailingButtonsSize.width)
                            } else {
                                /// If the trigger has not been crossed, the offset backs to the start position
                                withAnimation {
                                    self.xOffset = self.startOffset
                                }
                            }
                            
                            self.startOffset = self.xOffset
                        }
                )
        }
    }
    
    // MARK: - Initializers
    
    init(leadingButtons: [Button<Text>] = [], trailingButtons: [Button<Text>] = [], content: @escaping () -> Content) {
        self.content = content
        self.leadingButtons = leadingButtons
        self.trailingButtons = trailingButtons
    }
    
    // MARK: - View builder funcs
    
    private func buttonsStack(buttons: [Button<Text>]) -> some View {
        HStack(spacing: .zero) {
            ForEach(0..<buttons.count, id: \.self) { index in
                buttons[index]
                    .controlSize(.large)
                    .frame(minWidth: 70, maxHeight: .infinity)
            }
        }
    }
    
    @ViewBuilder
    private func hidden(_ isHidden: Bool, _ content: () -> some View) -> some View {
        if isHidden {
            content().hidden()
        } else {
            content()
        }
    }
    
    // MARK: - Offset calculators
    
    private func onDragStart(_ currentTranslation: CGFloat, buttonsWidth: CGFloat) -> CGFloat {
        guard buttonsWidth != 0 else { return 0 }
        
        /// The difference between the magnitude of the offset and the button width
        /// If it's negative, the offset hasn't reached the button bounds yet
        var offset = abs(currentTranslation) - buttonsWidth
        /// If it's positive, the further offset needs to be slowed down
        offset /= offset > 0 ? self.slowingRate : 1
        /// Add the button's width back to the offset
        offset += buttonsWidth
        /// Direct the offset to the needed side from the initial offset position
        offset *= currentTranslation.sign == .minus ? -1 : 1
        
        return offset
    }
    
    private func onDragResume(_ currentTranslation: CGFloat) -> CGFloat {
        
        /// Check if the gesture is continuing to pull in the same direction or returning to the initial position
        let isSameDirection = self.startOffset.sign == currentTranslation.sign
        /// Check if the offset has crossed the initial point while returning
        let didReachInitialPoint = (abs(currentTranslation) > abs(self.startOffset)) && !isSameDirection
        /// The magnitude of the offset
        var offset = abs(currentTranslation)
        /// If the initial position has been reached, calculate the remaining offset
        offset -= didReachInitialPoint ? abs(self.startOffset) : 0
        /// If the gesture is continuing to pull in the same direction or is pulling beyond the screen bounds, slow down the offset
        offset /= isSameDirection || didReachInitialPoint ? self.slowingRate : 1
        /// Direct the offset to the needed side the starting offset position
        offset *= currentTranslation.sign == .minus ? -1 : 1
        /// Add the start offset value
        /// If the initial point has been reached, the offset is calculated from it
        offset += didReachInitialPoint ? 0 : self.startOffset
        
        return offset
    }
    
    private func onDragEnd(_ currentTranslation: CGFloat, buttonsWidth: CGFloat)  {
        
        /// Check if this gesture is returning to the initial position
        let isSameDirection = self.startOffset.sign == currentTranslation.sign || self.startOffset == 0
        let isBackGesture = (abs(self.startOffset) > abs(self.xOffset)) || !isSameDirection
        /// Detect the offset direction
        let offsetDirection: CGFloat = currentTranslation.sign == .minus ? -1 : 1
        let offset = isBackGesture ? 0 : buttonsWidth * offsetDirection
        
        withAnimation {
            self.xOffset = offset
            
            if offset > 0 {
                self.isLeadingButtonsHidden = isBackGesture
                self.isTrailingButtonsHidden = !isBackGesture
            } else if offset < 0 {
                self.isLeadingButtonsHidden = !isBackGesture
                self.isTrailingButtonsHidden = isBackGesture
            } else {
                self.isLeadingButtonsHidden = isBackGesture
                self.isTrailingButtonsHidden = isBackGesture
            }
        }
    }
}
