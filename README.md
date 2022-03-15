# Repeat
Demo of using Swift Argument Parser and await/async

1. Commit [be39f86](https://github.com/MarcoEidinger/Repeat/commit/be39f867dda1d2ee36425b2a767f3aa6f6f3fb2e): I created a new package with `swift package init --type executable --name RepeatCommandLineTool`. This Swift package can be build and executed with `swift run`
2. Commit [295881c](https://github.com/MarcoEidinger/Repeat/commit/295881caa4514e948c9b5e6812671c24defbda50): I added Swift Argument Parser (`1.0.0`) and Apple's `Repeat` example (sync processing). Build and run with `swift run repeat --count 5 HelloWorld`
3. Commit [929075b](https://github.com/MarcoEidinger/Repeat/commit/929075b3cf15db92f3dfba296397083ce610142a): I used `@main` attribute and therefore had to rename `main.swift` file to avoid the error `'main' attribute cannot be used in a module that contains top-level code`
4. Commit [3909324](https://github.com/MarcoEidinger/Repeat/commit/39093245f3ff30e3bb42e70f181ec1435d3706f4): I added new code artifacts to convert the example to use async/await
5. Commit [6be7396](https://github.com/MarcoEidinger/Repeat/commit/6be7396a846a16e4e0662adffbde6de477ed747a): I adopted Swift ArgumentParser `1.1.0` which has native support for async/await.  

> If you encounter the error `dyld: Library not loaded: @rpath/libswift_Concurrency.dylib` when running the command-line tool from within Xcode on a macOS version < 12.0 then you can enable the commented code in `Package.swift` (introduced with commit [26c67af](https://github.com/MarcoEidinger/Repeat/commit/26c67af70fdb88287445821853f5fe61e40f1237))
