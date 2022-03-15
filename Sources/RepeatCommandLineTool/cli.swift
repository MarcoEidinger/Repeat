import ArgumentParser

@main
struct Repeat: ParsableCommand, AsyncParsableCommand {
    @Flag(help: "Include a counter with each repetition.")
    var includeCounter = false

    @Option(name: .shortAndLong, help: "The number of times to repeat 'phrase'.")
    var count: Int?

    @Argument(help: "The phrase to repeat.")
    var phrase: String

    mutating func run() async throws {
        let repeatCount = count ?? .max
        await asyncRepeat(phrase: phrase, repeatCount: repeatCount)
    }



    func asyncRepeat(phrase: String, repeatCount: Int) async {
        try? await Task.sleep(nanoseconds: 5 * 1_000_000_000) // dummy use of an aysnc operation .. wait 5 seconds :)
        for i in 1...repeatCount {
            if includeCounter {
                print("\(i): \(phrase)")
            } else {
                print(phrase)
            }
        }
    }
}
