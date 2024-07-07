# Clipboard History Tracker

Hey there! 👋 Welcome to my Clipboard History Tracker app. I built this nifty little tool to keep track of my clipboard history on macOS, and I thought you might find it useful too!

## What does it do?

Ever lost something you copied a while ago? Frustrating, right? This app solves that problem by keeping track of your 30 most recent clipboard items. Here's what it can do:

- 📋 Tracks the last 30 items you've copied
- 🖥 Displays them in a sleek, easy-to-read list
- 🔍 Lets you quickly find and re-copy old clipboard items

## Why I made it

I often found myself copying multiple things in quick succession, only to realize I needed something I copied a few minutes ago. Digging through my clipboard history manually was a pain, so I decided to create this app to make my life (and hopefully yours) a bit easier.

## How to Use

To use this Clipboard History Tracker app, follow these steps:

1. Clone this repository.
2. Build the app by executing the following command in your terminal:
   ```
   clang++ -fobjc-arc -framework Cocoa *.mm -o clipboard_tracker; ./clipboard_tracker
   ```
   This will open the app's graphical user interface (GUI).
3. Keep the terminal window and GUI window open while using the app. Closing either of them will exit the app.
4. Copy items as you normally would.
5. When you need to find something you copied earlier, open the app and click on the desired item.
6. The selected item will be copied back to your clipboard, ready to be pasted.

Enjoy the convenience of easily accessing your clipboard history with this sleek and user-friendly app!
