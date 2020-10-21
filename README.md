# Bowling

## How to use

This project has been built on Xcode 12.0 which can be downloaded on the Mac App Store, or here: https://developer.apple.com/download/more/
1. Download or clone this repository on your Mac
2. Open **Bowling.xcodeproj** with Xcode
3. Run the tests with `Cmd+U`
4. Run the app with `Cmd+R`

## Thoughts

This exercise follows as strictly as possible the rules specified in https://github.com/stephane-genicot/katas/blob/master/Bowling.md

###  Usage

This app is very simple: it shows the scores in a list view of bowling frames with the total below. The initial view loads the case of all spares (`5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5`). A button is there to load additional predefined scores.

### UI

I applied a very basic MVP approach. I am more used to MVVM with RxSwift and Reusable, but I wanted to keep this project *"barebones"* and saw an opportunity to try MVP here.

### Validation

Even though the description specifically states that no invalid scores wil be given, production code would need guard statements to validate the given input (number of frames, accepted characters, characters per frame, max points per frame, etc.). Even if we pinky-promise that the data will be valid, it can and will fail eventually (especially after database migrations - been there, done that).

The many force-unwrapping in the code are also due to these validity assumptions. Force-unwrapping should otherwise be discouraged.

### Version control

I deliberately "overdid" granular commits (non-building failing test, then failing test, then working test). Whether it should be separate commits or be together in one commit is at the team's discretion. I've seen both and I'm fine with either.

### Code

I was hoping I could do some fancy one-liner like `frames.map { score(for: $0) }.reduce(0, +)` but the forward-going calculation of scoring prevented me to. For this reason I have to tell that the whole exercise is clever.

![Preview](preview.png =409x)
