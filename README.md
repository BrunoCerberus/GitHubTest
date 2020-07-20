# GitHubTest

## Observations before start
If for some reason, the request comes not authorized because of a OAUTH token, use this token `99a4bc3599e653a1593a2052a8e45643ceee2e37` instead in `BaseService.swift`, just change the value of the `ApiKey`and use the new one, if the problem still persists, leave the variable value as empty `""`. This hapens because there is a security system on GitHub that removes every OAUTH token that appears in a public repository. I separated the the app in three schemes, one for normal using, and the other two to Unit and UI testing. The Carthage won't be necessary since it already includes all compiled dependencies in the repository, but if something goes wrong with any dependecie, just run `carthage update --platform iOS`

Schemes:
 - GitHubTest (normal using)
 - GitHubTestUnitTest (Unit tests)
 - GitHubTestUITesting (UI testing with KIF)

I implemented the TableView in two ways:
 - The first one was in the classic way, using UITableViewDelegate and UITableViewDataSource in the HomeViewController
 - The second was implemented using RxSwift and RxCocoa (Reactive) in the RepoDetailViewController
 
## Important ⚠️
Run in the simulator, for some reason when it runs on a physical device a parse error occurs, didn't have time to find out. 

## Requirements for running this project
- Xcode 11.6
- SwiftLint
- iOS 13+
- Swift 5.2.4+
 
## Development Roadmap

- [x] Swift 5+
- [x] Codable
- [x] MVVM
- [x] Xib
- [x] Coordinator
- [x] Unit Tests
- [x] UI Testing
- [x] Network layer
- [x] GitHub Developer V3 API
- [x] Dependencies Manager (Carthage)
- [x] Code Analyser (Swiftlint)
- [x] POP
- [x] RxSwift
- [x] High Order Function
- [x] Custom components
- [x] UserDefaults
- [x] Infinite Scrolling
- [x] Pull-to-refresh
- [x] Notification Center
- [x] Grand Central Dispatch
- [x] Accessibility (Only VoiceOver to some elements)

## Features
- [x] Home
- [x] Filter
- [x] Detail

## Dependencies used
- RxSwift
- KIF (UI Testing framework)
- OHHTTPStubs (stub network responses)

## Author

| [<img src="https://avatars3.githubusercontent.com/u/10541956?s=400&u=eba6b61af608c7dbc1d36cbf2abacb880d9c6a71&v=4" width="48"><br><sub>@BrunoCerberus</sub>](https://github.com/BrunoCerberus) |
| :---: |

## License

All the code available under the MIT license. See [LICENSE](LICENSE).

```
MIT License

Copyright (c) 2020 Bruno Lopes de Mello

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
