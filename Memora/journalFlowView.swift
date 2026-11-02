////
////  journalFlowView.swift
////  Memora
////
////  Created by Fay on 25/02/1448 AH.
////
//
//import SwiftUI
//
//struct JournalFlowView: View {
//
//    let journey: Journey
//
//    @State private var currentPage = 0
//    @State private var rotation = 0.0
//
//    var body: some View {
//
//        ZStack {
//
//            Color(
//                red: 245/255,
//                green: 237/255,
//                blue: 227/255
//            )
//            .ignoresSafeArea()
//
//            VStack(spacing: 0) {
//
//                // Header ثابت
//                Text(journey.country)
//                    .font(
//                        .system(
//                            size: 32,
//                            weight: .bold,
//                            design: .serif
//                        )
//                    )
//                    .foregroundStyle(
//                        Color(
//                            red: 44/255,
//                            green: 62/255,
//                            blue: 46/255
//                        )
//                    )
//                    .frame(
//                        maxWidth: .infinity,
//                        alignment: .leading
//                    )
//                    .padding(.horizontal, 25)
//                    .padding(.top, 50)
//
//                Divider()
//                    .padding(.horizontal, 25)
//                    .padding(.top, 8)
//
//                Spacer()
//
//                // الكتاب فقط هو اللي يلف
//                ZStack {
//                    bookPage
//                }
//                .frame(height: 570)
//                .rotation3DEffect(
//                    .degrees(rotation),
//                    axis: (x: 0, y: 1, z: 0),
//                    anchor: .center,
//                    perspective: 0.5
//                )
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    nextPage()
//                }
//
//                Spacer()
//
//             
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//    }
//
//    // الصفحات داخل الكتاب
//    @ViewBuilder
//    var bookPage: some View {
//
//        switch currentPage {
//
//        case 0:
//            MyJourneyView(
//                journey: journey
//            )
//
//        case 1:
//            JournalsPageLast()
//
//        case 2:
//            Memorypage()
//
//        case 3:
//            //journais_page_story_()
//
//        case 4:
//            JournalDay1()
//
//        default:
//            JournalDayView()
//        }
//    }
//
//    // حركة قلب الكتاب
//    func nextPage() {
//
//        guard currentPage < 5 else {
//            return
//        }
//
//        // الكتاب يلف لليمين
//        withAnimation(
//            .easeIn(duration: 0.35)
//        ) {
//            rotation = -90
//        }
//
//        DispatchQueue.main.asyncAfter(
//            deadline: .now() + 0.35
//        ) {
//
//            currentPage += 1
//
//            rotation = 90
//
//            withAnimation(
//                .easeOut(duration: 0.35)
//            ) {
//                rotation = 0
//            }
//        }
//    }
//}
//
//
//// Preview
//struct JournalFlowView_Previews: PreviewProvider {
//
//    static var previews: some View {
//
//        NavigationStack {
//
//            JournalFlowView(
//                journey: Journey(
//                    country: "France",
//                    city: "Paris",
//                    date: "June 2026",
//                    image: "France"
//                )
//            )
//        }
//    }
//}
