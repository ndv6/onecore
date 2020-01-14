# ONECore

[![CI Status](https://img.shields.io/travis/fradenza/ONECore.svg?style=flat)](https://travis-ci.org/fradenza/ONECore)
[![Version](https://img.shields.io/cocoapods/v/ONECore.svg?style=flat)](https://cocoapods.org/pods/ONECore)
[![License](https://img.shields.io/cocoapods/l/ONECore.svg?style=flat)](https://cocoapods.org/pods/ONECore)
[![Platform](https://img.shields.io/cocoapods/p/ONECore.svg?style=flat)](https://cocoapods.org/pods/ONECore)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 10.0+
* Xcode 10+
* Swift 4.2

## Installation

ONECore is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ONECore'
```

## Dependencies
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)

## Deployment
1. Make sure you have [`podspec-bump`](https://github.com/azu/podspec-bump) installed on your local machine. **If not**, you can install with `npm`.
    ```
    npm install -g podspec-bump
    ```
2. Checkout latest `develop` branch.
    ```
    git checkout develop
    git pull origin develop
    ```
3. Make sure you have no error or warning by execute the comment below from `core-ios` project root directory:
    ```
    pod lib lint
    ```
    If there is an error or warning, then you need to fix it before continue to the next deployment step.
4. Create new branch from the latest `develop` to bump the version.
    ```
    git checkout -b chore/bump-version
    ```
5. Bump the version using `podspec-bump`.

    a. Major Update

        podspec-bump major -w

    b. Minor Update
    
        podspec-bump minor -w
    
    c. Patch Update
    
        podspec-bump patch -w
6. Commit and push the changes.
    ```
    git add .
    git commit -m 'bump version from <old-version> to <new-version>'
    git push origin chore/bump-version
    ```
7. Create new Pull Request from `chore/bump-version` into `develop` branch.
8. After your pull request from `Step 7` merged, you can continue to create another new pull request from `develop` into `master`.
9. After your pull request from `Step 8` merged, you can checkout `master` branch and pull the latest version.
    ```
    git checkout master
    git pull origin master
    ```
10. Create a new tag from `master` branch and the `<tagname>` should follow the `Step 5`'s result.
    ```
    git tag <tagname>
    ```
11. Push your new tag.
    ```
    git push origin refs/tags/<tagname>
    ```
12. Register new trunk session.
    ```
    pod trunk register onelabsco@gmail.com
    ```
13. `onelabsco@gmail.com` should quickly get an email from Cocoapods to verify the new session, verify the account by clicking the link provided in the email.
14. Finally, release your latest version to the public cocoapods.
    ```
    pod trunk push ONECore.podspec --allow-warnings
    ```

## Author

onelabs, onelabsco@gmail.com

## License

ONECore is available under the MIT license. See the LICENSE file for more info.
