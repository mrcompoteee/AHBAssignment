# AHBAssignment
Mobile application that displays real-time exchange rates for a list of selected crypto assets using the CoinLore API.

# Instructions
1. Clone the repo. No package management setup required.
2. Build and run the app by pressing Product -> Run in Xcode. 
3. To run the tests, press Product -> Test in Xcode.
4. Minimum deployment target is iOS 18.0

# Tools used
1. Xcode 16.3

# Potential Improvements
1. Search. CoinLore API doesn't provide an option to search through available coins. Besides that, the api allows to fetch not more than 100 coins at a time, meaning we also can't search through the list locally. I did implement pagination though :)
2. Proper DI. Didn't want to over-engineer it for the test task, but obviously I wouldn't store all my dependencies inside of a singleton. We can use some third-party DI framework or build our own DI container and then hide repository details behind a protocol. Injection itself can be performed via initializers or property wrappers.
3. Large numbers like ATH Volume (e.g. 344187126292428700) are not exactly representable as Double. We better use Decimal or some custom types like BigInt/BigNum to achieve the ideal precision.

# Screenshots

![Simulator Screenshot - iPhone 16 Pro - 2025-05-21 at 10 55 43](https://github.com/user-attachments/assets/51e5a392-aed8-41d0-a2a1-10d3842a1295)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-21 at 10 57 04](https://github.com/user-attachments/assets/b1da4b30-87e3-4ab2-9919-b32bef55091a)


