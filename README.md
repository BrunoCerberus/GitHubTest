# GitHubTest

## Observations before start
Project almost finished, some points are different from the layout, but due the short deadline it was the best i could do, hope you like it 😁. Is for some reason, the request comes not authorized because of a OAUTH token, use this token `99a4bc3599e653a1593a2052a8e45643ceee2e37` instead in `BaseService.swift`, just change the value of the `ApiKey`and use the new one, if the problem still persists, leave the variable value as empty `""`. This hapens because there is a security system on GitHub that removes every OAUTH token that appears in a public repository.

## Requirements for running this project
- Xcode 11.6
- SwiftLint
- iOS 11+
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
- [x] Persistence with UserDefaults
- [x] Infinite Scrolling
- [x] Pull-to-refresh
- [x] Notification Center
- [x] Grand Central Dispatch
- [ ] Accessibility

## Features
- [x] Home
- [x] Filter
- [x] Detail

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
