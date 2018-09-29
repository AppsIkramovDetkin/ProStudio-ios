# ProStudio iOS

## Codestyle

Codestyle from RayWenderlich should be used:  [_Swift_](https://github.com/raywenderlich/swift-style-guide) and [Objective-C](https://github.com/raywenderlich/objective-c-style-guide)

## Specific rules

### Code

-   SwiftLint warnings should not be ignored
-   Use 2-space intends
-   When dealing with legacy code, fix formatting within the whole method
-   Move constant values to the top of the file
-   Don't leave comment's trash in your code when pushing to origin
-   Move all used literal strings to  `Localized.strings`
-   Use unified xibs for all devices instead of "...xib", "..._iphone5.xib", "..._ipad.xib"
-   Constants declaration:
-   Inside .swift - only calss propperties are supported i.e.  `static let name = value`
-   Colors should be used through the constants declared in UIColor+PS.swift, if it not exist, you need to create it
-   For fonts - use UIFont extension methods from UIFont+PS.swift, if it not exist, you need to create it
-   Replace all  `deprecated`functionality in scope of changed method. If for some reason you can't do that, provide full description  `// why`above the line.

### Process

-   Do not fallback build version in  `Info.plist`to a smaller number
-   Do not make any changes with Pod updates within the same commit
-   Do smoke tests before providing your pull request to code review
-   Use  `xxx.y`for build and version number, where  `y`in 0..9
-   Do not discuss in PM, only in Slack Chat, named  _Prostudio_

### Git Flow
-   Create branch, inherit from master named by your task number and name in JIRA. For example, if task name is "PS-6 Design screen", your branch should named as "PS-6_design_screen"
-   Making changes inside your branch
-   When it's done, push to origin in your branch
-   Create Pull Request from your branch to test, in comment link to JIRA task and build version, which incremented in previous point
-   In JIRA transfer task into Code Review and write link on created Pull Request
-   When task passed by code review, team lead will be merge your task into test branch, and likely there will be some merge conflicts, which you must resolve

Resolving test conflicts after Code Review:
- Merge test branch into your branch
- Resolve merge conflicts
- Make smoke tests
- Push to origin
