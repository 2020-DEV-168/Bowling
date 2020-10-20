# Bowling

## How to use

This project has been built on Xcode 12.0 which can be downloaded on the Mac App Store, or here: https://developer.apple.com/download/more/
1. Download or clone this repository on your Mac
2. Open **Bowling.xcodeproj** with Xcode
3. Run the tests with Cmd+U

## Thoughts

This exercise follows as strictly as possible the rules specified in https://github.com/stephane-genicot/katas/blob/master/Bowling.md

###  Usage

It is not an iOS app in the traditional matter, i.e. running the app does nothing but a blank screen. Only Test cases exploit the code.

### Validation

Even though the description specifically states that no invalid rolls wil be given, production code would need a guard statement to validate the given input (number of frames, accepted characters, characters per frame, max points per frame, etc.). Even if we pinky-promise that the data will be valid, it can and will fail eventually (especially after database migrations - been there, done that).

### Version control

I deliberately "overdid" granular commits (non-building failing test, then failing test, then working test). Whether it should be separate commits or be together in one commit is at the team's discretion. I've seen both and I'm fine with either.

### Code

I was hoping I could do some fancy one-liner like `frames.map { score(for: $0) }.reduce(0, +)` but the forward-going calculation of scoring prevented me to. For this reason I have to tell that the whole exercise is clever.
