//
//  JourneyStoryGenerator.swift
//  Memora
//

import Foundation
import FoundationModels

@MainActor
final class JourneyStoryGenerator {

    // MARK: - AI Session

    private let session = LanguageModelSession(
        instructions: """
        You are a travel memory storyteller for the QVoyage app.

        Your job is to turn the traveler's completed photography
        challenges and personal notes into a short, meaningful,
        nostalgic travel story.

        The story should feel like opening an old travel journal
        and remembering the little moments that made the trip special.

        IMPORTANT RULES:

        - Keep the story SHORT.
        - Write approximately 60 to 90 words.
        - Use 1 or 2 short paragraphs.
        - Focus mainly on the traveler's personal notes.
        - Use the photography challenges only to provide context.
        - Capture memorable little moments and details.
        - Make the story warm, nostalgic, and personal.
        - Make it feel like a memory, not a summary.
        - Connect the memories naturally.
        - Do NOT list the days.
        - Do NOT describe every challenge one by one.
        - Do NOT repeat challenge wording unnecessarily.
        - Do NOT invent events, people, places, feelings,
          or experiences that are not supported by the data.
        - Do NOT say "the user" or "the traveler".
        - Do NOT mention quests, challenges, or app features.
        - Do NOT use generic phrases when personal notes
          provide specific memories.
        - Prefer specific details from the notes over generic
          travel descriptions.
        - End with a gentle memorable closing sentence.
        """
    )


    // MARK: - Generate Story

    func generateStory(
        country: String,
        challenges: [challengeData]
    ) async throws -> String {

        // ترتيب الأيام

        let sortedChallenges =
            challenges.sorted {
                $0.day < $1.day
            }


        // إذا ما فيه أيام

        guard !sortedChallenges.isEmpty else {

            return """
            \(country) became one of those journeys remembered through small moments, photographs, and details worth keeping.
            """
        }


        // MARK: - Build Memories

        var memoriesText = ""


        for challenge in sortedChallenges {

            let note =
                challenge.note
                    .trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )


            memoriesText += """

            Day \(challenge.day)

            Photo:
            \(challenge.challengeText)

            Personal memory:
            \(note.isEmpty ? "No personal note." : note)

            """
        }


        // MARK: - Prompt

        let prompt = """
        Write a short nostalgic travel story about a trip to \(country).

        Here are the travel memories:

        \(memoriesText)


        STORY GOAL:

        This should NOT feel like a summary of the trip.

        It should feel like someone opening their travel journal
        later and remembering the small moments that made the
        journey special.

        Use personal notes as the most important source.

        Photography prompts are only context for understanding
        what was happening.


        WRITING STYLE:

        - warm
        - nostalgic
        - personal
        - natural
        - simple
        - emotionally memorable
        - like a travel journal


        IMPORTANT:

        - 60 to 90 words maximum
        - 1 or 2 short paragraphs
        - Do not list Day 1, Day 2, etc.
        - Do not describe every photo
        - Do not mention "challenge" or "quest"
        - Do not invent memories
        - Do not invent emotions
        - Do not invent locations
        - Do not invent people
        - Use specific details from the notes whenever possible
        - Connect the strongest memories naturally
        - End with a short nostalgic closing thought

        Return ONLY the story.
        """


        // MARK: - Generate

        do {

            let response =
                try await session.respond(
                    to: prompt
                )


            let generatedStory =
                response.content
                    .trimmingCharacters(
                        in: .whitespacesAndNewlines
                    )


            guard !generatedStory.isEmpty else {

                return fallbackStory(
                    country: country,
                    challenges: sortedChallenges
                )
            }


            return generatedStory

        } catch {

            print(
                "❌ Journey story generation failed:",
                error
            )


            return fallbackStory(
                country: country,
                challenges: sortedChallenges
            )
        }
    }


    // MARK: - Fallback Story

    private func fallbackStory(
        country: String,
        challenges: [challengeData]
    ) -> String {

        let notes =
            challenges
                .map {
                    $0.note
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                }
                .filter {
                    !$0.isEmpty
                }


        // إذا عندنا Notes

        if !notes.isEmpty {

            let selectedNotes =
                notes
                    .prefix(3)
                    .joined(
                        separator: " "
                    )


            return """
            Looking back on \(country), it's the little moments that remain the clearest. \(selectedNotes)

            Somehow, those small memories became the ones worth keeping.
            """
        }


        // إذا ما فيه Notes

        return """
        Looking back on \(country), the journey lives on through little details captured along the way. Each photograph holds a small piece of the places, colors, and moments that made the trip unique.

        Some journeys end, but their smallest moments stay with us.
        """
    }
}
