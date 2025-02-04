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
                            
                            /// Проверка, начинается ли сдвиг со стартовой точки
                            if self.startOffset == 0 {
                                /// Определение направления сдвига
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
                            
                            /// Проверка, преодолен ли триггер для перехода к целевому положению сдвига
                            if value.translation.width > self.leadingButtonsSize.width * self.triggerRate {
                                self.onDragEnd(value.translation.width, buttonsWidth: self.leadingButtonsSize.width)
                            } else if value.translation.width < -self.trailingButtonsSize.width * self.triggerRate {
                                self.onDragEnd(value.translation.width, buttonsWidth: self.trailingButtonsSize.width)
                            } else {
                                /// Если сдвиг не преодолел триггер, то возвращаем к стартовому положению сдвига
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
        
        /// Разница между модулем сдвига и шириной кнопок. Если отрицательная, то сдвиг ещё не достиг границы кнопок
        var offset = abs(currentTranslation) - buttonsWidth
        /// Если положительная, то нужно замедлить только дальнейший сдвиг
        offset /= offset > 0 ? self.slowingRate : 1
        /// Возвращаем ширину кнопок к сдвигу
        offset += buttonsWidth
        /// Направление сдвиг в нужную сторону из изначального значения сдвига
        offset *= currentTranslation.sign == .minus ? -1 : 1
        
        return offset
    }
    
    private func onDragResume(_ currentTranslation: CGFloat) -> CGFloat {
                
        /// Проверка, тянется ли жест в том же направлении или возвращается к исходному значению
        let isSameDirection = self.startOffset.sign == currentTranslation.sign
        /// Проверка, преодолел ли сдвиг изначальное положение при возвращении
        let didReachInitialPoint = (abs(currentTranslation) > abs(self.startOffset)) && !isSameDirection
        /// Значение сдвига по модулю
        var offset = abs(currentTranslation)
        /// Если достигнуто изначальное положение, вычисляем остаток сдвига
        offset -= didReachInitialPoint ? abs(self.startOffset) : 0
        /// Замедление сдвига, если жест в том же направлении или тянется за границы экрана
        offset /= isSameDirection || didReachInitialPoint ? self.slowingRate : 1
        /// Направление сдвига в нужную сторону из изначального значения сдвига
        offset *= currentTranslation.sign == .minus ? -1 : 1
        /// Добавляем значение стартового сдвига
        /// Если достигнуто изначальное положение, то отступ считаем от него
        offset += didReachInitialPoint ? 0 : self.startOffset
                
        return offset
    }
    
    private func onDragEnd(_ currentTranslation: CGFloat, buttonsWidth: CGFloat)  {
                
        /// Проверка, является ли это жестом возвращения к изначальному положению
        let isSameDirection = self.startOffset.sign == currentTranslation.sign || self.startOffset == 0
        let isBackGesture = (abs(self.startOffset) > abs(self.xOffset)) || !isSameDirection
        /// Определение направления сдвига
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
