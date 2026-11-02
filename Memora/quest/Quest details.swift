//
//  QuestDetailView.swift
//  Memora
//

import SwiftUI
import SwiftData
import PhotosUI
import UIKit

struct QuestDetailView: View {

    // MARK: - Challenge

    @Bindable var challenge: challengeData

    // MARK: - Trip

    @Bindable var trip: TripPreferences

    // MARK: - Environment

    @Environment(\.modelContext)
    private var modelContext

    @Environment(\.dismiss)
    private var dismiss


    // MARK: - Image Picker

    @State private var selectedPhotoItem:
        PhotosPickerItem?

    @State private var selectedImage:
        UIImage?

    @State private var showPhotoOptions =
        false

    @State private var showCamera =
        false

    @State private var showPhotoPicker =
        false


    // MARK: - Body

    var body: some View {

        ZStack {

            Color("Backgroundcolor")
                .ignoresSafeArea()


            ScrollView(
                showsIndicators: false
            ) {

                VStack(
                    spacing: 0
                ) {

                    // MARK: Header

                    header


                    // MARK: Quest Card

                    questCard
                }
                .padding(
                    .bottom,
                    40
                )
            }
        }


        // MARK: - Photo Options

        .confirmationDialog(
            "Add Your Quest Photo",
            isPresented:
                $showPhotoOptions,
            titleVisibility:
                .visible
        ) {

            Button(
                "Take Photo"
            ) {

                showCamera = true
            }


            Button(
                "Choose From Photos"
            ) {

                showPhotoPicker = true
            }


            Button(
                "Cancel",
                role: .cancel
            ) {}
        }


        // MARK: - Camera

        .sheet(
            isPresented:
                $showCamera
        ) {

            QuestCameraPicker { image in

                saveImage(
                    image
                )
            }
        }


        // MARK: - Photo Library

        .photosPicker(
            isPresented:
                $showPhotoPicker,

            selection:
                $selectedPhotoItem,

            matching:
                .images
        )


        // MARK: - Selected Photo

        .onChange(
            of: selectedPhotoItem
        ) { _, newItem in

            guard let newItem
            else {
                return
            }


            Task {

                if let data =
                    try? await newItem
                        .loadTransferable(
                            type: Data.self
                        ),

                    let image =
                        UIImage(
                            data: data
                        ) {

                    await MainActor.run {

                        saveImage(
                            image
                        )
                    }
                }
            }
        }


        // MARK: - Navigation Bar

        .navigationBarBackButtonHidden(
            false
        )
    }


    // MARK: - Save Image

    private func saveImage(
        _ image: UIImage
    ) {

        selectedImage =
            image


        challenge.imageData =
            image.jpegData(
                compressionQuality:
                    0.8
            )


        do {

            try modelContext.save()

        } catch {

            print(
                "❌ Failed to save image:",
                error
            )
        }
    }
}


// MARK: - Header

extension QuestDetailView {

    var header: some View {

        ZStack {

            Color.clear


            HStack(
                alignment: .center
            ) {

                // MARK: Left Character

                Image(
                    "persone 1"
                )
                .resizable()
                .scaledToFit()
                .frame(
                    width: 120,
                    height: 145
                )


                Spacer()


                // MARK: Title

                VStack(
                    spacing: 6
                ) {

                    Text(
                        "Quest"
                    )
                    .font(
                        .system(
                            size: 36,
                            weight: .bold,
                            design: .serif
                        )
                    )
                    .foregroundStyle(
                        Color(
                            "FontColor"
                        )
                    )


                    Text(
                        "Day \(challenge.day)"
                    )
                    .font(
                        .system(
                            size: 14,
                            weight: .medium
                        )
                    )
                    .foregroundStyle(
                        Color(
                            "FontColor"
                        )
                    )
                }


                Spacer()


                // MARK: Stamp

                Image(
                    "stamp 1"
                )
                .resizable()
                .scaledToFit()
                .frame(
                    width: 100,
                    height: 100
                )
            }
            .padding(
                .horizontal,
                30
            )
            .padding(
                .top,
                65
            )
        }
    }
}


// MARK: - Quest Card

extension QuestDetailView {

    var questCard: some View {

        VStack(
            alignment: .leading,
            spacing: 22
        ) {

            // MARK: - Adventure

            HStack(
                spacing: 8
            ) {

                Image(
                    systemName:
                        "figure.hiking"
                )


                Text(
                    "Adventure"
                )
                .font(
                    .system(
                        size: 18,
                        weight: .semibold
                    )
                )
            }
            .foregroundStyle(
                .black
            )
            .padding(
                .horizontal,
                18
            )
            .padding(
                .vertical,
                10
            )
            .background {

                Capsule()
                    .fill(
                        Color(
                            "buttoncolor"
                        ).opacity(0.45)
                    )
                    
            }


            // MARK: - Challenge Title

            Text(
                challenge.challengeText
            )
            .font(
                .system(
                    size: 25,
                    weight: .bold,
                    design: .serif
                )
            )
            .foregroundStyle(
                Color(
                    "FontColor"
                )
            )


            // MARK: - Challenge Description

            Text(
                challenge.challengeDetailSheet
            )
            .font(
                .system(
                    size: 19,
                    design: .serif
                )
            )
            .foregroundStyle(
                Color(
                    "FontColor"
                )
            )


            // MARK: - Upload Photo

            Button {

                showPhotoOptions = true

            } label: {

                RoundedRectangle(
                    cornerRadius: 28
                )
                .fill(
                    Color(
                        "Backgroundcolor"
                    )
                )
                .frame(
                    height: 235
                )
                .overlay {

                    RoundedRectangle(
                        cornerRadius: 28
                    )
                    .stroke(
                        Color.black,
                        lineWidth: 2
                    )
                }
                .shadow(
                    color:
                        .black.opacity(
                            0.12
                        ),
                    radius: 8,
                    x: 0,
                    y: 5
                )
                .overlay {

                    photoContent
                }
            }
            .buttonStyle(
                .plain
            )


            // MARK: - Note

            VStack(
                alignment: .leading,
                spacing: 12
            ) {

                Text(
                    "Write your note"
                )
                .font(
                    .system(
                        size: 22,
                        weight: .bold,
                        design: .serif
                    )
                )
                .foregroundStyle(
                    Color(
                        "FontColor"
                    )
                )


                TextField(
                    "Add your note...",
                    text:
                        $challenge.note
                )
                .padding(
                    .horizontal,
                    20
                )
                .frame(
                    height: 58
                )
                .background {

                    Capsule()
                        .fill(
                            Color(
                                red:
                                    230 / 255,
                                green:
                                    224 / 255,
                                blue:
                                    215 / 255
                            )
                        )
                }
            }


            // MARK: - How To Complete

            Text(
                "How to Complete"
            )
            .font(
                .system(
                    size: 28,
                    weight: .bold,
                    design: .serif
                )
            )
            .foregroundStyle(
                Color(
                    "FontColor"
                )
            )
            .padding(
                .top,
                10
            )


            // MARK: - Steps

            HStack(
                alignment: .top
            ) {

                StepView(
                    icon:
                        "camera.fill",
                    title:
                        "Take a\nphoto"
                )


                Spacer()


                StepView(
                    icon:
                        "square.and.pencil",
                    title:
                        "Write\na note"
                )


                Spacer()


                StepView(
                    icon:
                        "square.and.arrow.up.fill",
                    title:
                        "Upload\nyour quest"
                )
            }


            // MARK: - Confirm

            Button {

                completeQuest()

            } label: {

                Text(
                    "Confirm"
                )
                .font(
                    .system(
                        size: 18,
                        weight: .semibold,
                        design: .serif
                    )
                )
                .foregroundColor(
                    .white
                )
                .frame(
                    maxWidth: .infinity
                )
                .frame(
                    height: 55
                )
                .background(
                    Color(
                        "buttoncolor"
                    )
                )
                .clipShape(
                    Capsule()
                )
                .shadow(
                    color:
                        .black.opacity(
                            0.15
                        ),
                    radius: 5,
                    x: 0,
                    y: 3
                )
            }
            .padding(
                .horizontal,
                28
            )
            .padding(
                .top,
                25
            )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(
            .horizontal,
            28
        )
        .padding(
            .top,
            10
        )
    }


    // MARK: - Complete Quest

    private func completeQuest() {

        // يجب رفع صورة

        guard challenge.imageData != nil else {

            print(
                "⚠️ Please upload a photo first."
            )

            showPhotoOptions = true

            return
        }


        // MARK: Mark As Completed

        challenge.isCompleted =
            true


        do {

            // حفظ الصورة + الملاحظة
            // + حالة التحدي

            try modelContext.save()


            print(
                "========== QUEST COMPLETED =========="
            )

            print(
                "Day:",
                challenge.day
            )

            print(
                "Challenge:",
                challenge.challengeText
            )

            print(
                "Image:",
                challenge.imageData != nil
                ? "YES"
                : "NO"
            )

            print(
                "Note:",
                challenge.note
            )

            print(
                "Completed:",
                challenge.isCompleted
            )

            print(
                "=====================================")


            // MARK:
            // العودة إلى SwiftUIViewMain
            //
            // لا نستخدم NavigationDestination هنا.
            // الصفحة السابقة هي SwiftUIViewMain.

            dismiss()


        } catch {

            print(
                "❌ Failed to save quest:",
                error
            )
        }
    }
}


// MARK: - Photo Content

extension QuestDetailView {

    @ViewBuilder
    var photoContent: some View {

        if let selectedImage {

            Image(
                uiImage:
                    selectedImage
            )
            .resizable()
            .scaledToFill()
            .frame(
                maxWidth: .infinity,
                maxHeight: 235
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 28
                )
            )
            .overlay {

                VStack {

                    Spacer()


                    HStack {

                        Spacer()


                        Image(
                            systemName:
                                "checkmark.circle.fill"
                        )
                        .font(
                            .system(
                                size: 32
                            )
                        )
                        .foregroundStyle(
                            .white
                        )
                        .padding(
                            15
                        )
                    }
                }
            }


        } else if let imageData =
                    challenge.imageData,

                  let image =
                    UIImage(
                        data: imageData
                    ) {

            Image(
                uiImage:
                    image
            )
            .resizable()
            .scaledToFill()
            .frame(
                maxWidth: .infinity,
                maxHeight: 235
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 28
                )
            )


        } else {

            VStack(
                spacing: 14
            ) {

                Circle()
                    .fill(
                        Color(
                            "buttoncolor"
                        )
                        .opacity(0.45)
                    )
                    .frame(
                        width: 82,
                        height: 82
                    )
                    .overlay {

                        Image(
                            systemName:
                                "photo.badge.plus"
                        )
                        .font(
                            .system(
                                size: 34
                            )
                        )
                        .foregroundStyle(
                            .black
                        )
                    }


                Text(
                    "Tap to upload photo"
                )
                .font(
                    .headline
                )
                .foregroundColor(
                    .gray
                )
            }
        }
    }
}


// MARK: - Step View

struct StepView: View {

    let icon: String

    let title: String


    var body: some View {

        VStack(
            spacing: 14
        ) {

            ZStack {

                Circle()
                    .fill(
                        Color(
                            "buttoncolor"
                        )
                        .opacity(0.45)
                    )
                    .frame(
                        width: 72,
                        height: 72
                    )


                Image(
                    systemName:
                        icon
                )
                .font(
                    .system(
                        size: 28
                    )
                )
                .foregroundColor(
                    .black
                )
            }


            Text(
                title
            )
            .font(
                .system(
                    size: 16,
                    weight: .medium,
                    design: .serif
                )
            )
            .multilineTextAlignment(
                .center
            )
            .foregroundStyle(
                Color(
                    "FontColor"
                )
            )
            .frame(
                width: 90
            )
        }
    }
}


// MARK: - Camera Picker

struct QuestCameraPicker:
    UIViewControllerRepresentable {

    @Environment(
        \.dismiss
    )
    private var dismiss


    let onImagePicked:
        (UIImage) -> Void


    func makeUIViewController(
        context: Context
    ) -> UIImagePickerController {

        let picker =
            UIImagePickerController()


        picker.sourceType =
            .camera


        picker.allowsEditing =
            false


        picker.delegate =
            context.coordinator


        return picker
    }


    func updateUIViewController(
        _ uiViewController:
            UIImagePickerController,
        context: Context
    ) {}


    func makeCoordinator()
        -> Coordinator {

        Coordinator(
            self
        )
    }


    final class Coordinator:
        NSObject,
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate {

        let parent:
            QuestCameraPicker


        init(
            _ parent:
                QuestCameraPicker
        ) {

            self.parent =
                parent
        }


        func imagePickerController(
            _ picker:
                UIImagePickerController,

            didFinishPickingMediaWithInfo info:
                [
                    UIImagePickerController.InfoKey:
                        Any
                ]
        ) {

            if let image =
                info[
                    .originalImage
                ] as? UIImage {

                parent.onImagePicked(
                    image
                )
            }


            parent.dismiss()
        }


        func imagePickerControllerDidCancel(
            _ picker:
                UIImagePickerController
        ) {

            parent.dismiss()
        }
    }
}


// MARK: - Preview

#Preview {

    NavigationStack {

        QuestDetailView(

            challenge:
                challengeData(
                    day: 1,

                    challengeText:
                        "Colorful Markets",

                    challengeDetailSheet:
                        "Photograph a vibrant market stall with a variety of colorful goods and lively atmosphere."
                ),

            trip:
                TripPreferences(

                    country:
                        "Italy",

                    startDate:
                        Date(),

                    endDate:
                        Calendar.current.date(
                            byAdding:
                                .day,
                            value:
                                3,
                            to:
                                Date()
                        )!,

                    travelWith:
                        "Solo",

                    difficulty:
                        "Easy",

                    photographyInterests:
                        [
                            "Architecture",
                            "Food"
                        ],

                    avoid:
                        []
                )
        )
    }
}
