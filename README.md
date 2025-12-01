# Union Shop — Flutter Coursework
**student name**- NIDHI PATEL 



This repository contains the coursework project for students enrolled in the **Programming Applications and Programming Languages (M30235)** and **User Experience Design and Implementation (M32605)** modules at the University of Portsmouth.

## Overview

The Student Union has an e-commerce website, which you can access via this link: [shop.upsu.net](https://shop.upsu.net)

In short, your task is to recreate the same website using Flutter. You must not start from scratch, as you need to begin by forking the GitHub repository that contains the incomplete code. [The getting started section of this document](#getting-started) will explain more. Once you have completed the application, you will submit the link to your forked repository on Moodle for assessment and demonstrate your application in a practical session. See the [submission](#submission) and [demonstration](#demonstration) sections for more information.

⚠️ The UPSU.net link on the navbar of the union website is a link to an external site. This is not part of the application that you need to develop. So ignore the link highlighted below:

![Union Shop Header](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_union_site_header.png)

## Getting Started

### Prerequisites

You have three options for your development environment:

1. **Firebase Studio** (browser-based, no installation required)
2. **University Windows computers** (via AppsAnywhere)
3. **Personal computer** (Windows or macOS)

Below is a quick guide for each option. For more information, you can refer to [Worksheet 0 — Introduction to Dart, Git and GitHub](https://manighahrmani.github.io/sandwich_shop/worksheet-0.html) and [Worksheet 1 — Introduction to Flutter](https://manighahrmani.github.io/sandwich_shop/worksheet-1.html).

**Firebase Studio:**

- Access [idx.google.com](https://idx.google.com) with a personal Google account
- Create a new Flutter Workspace (choose the Flutter template in the "Start coding an app" section)
- Once the Flutter Workspace is created, open the integrated terminal (View → Terminal) and link this project to your forked GitHub repository by running the following commands (replace `YOUR-USERNAME` in the URL):

  ```bash
  rm -rf .git && git init && git remote add origin https://github.com/YOUR-USERNAME/union_shop.git && git fetch origin && git reset --hard origin/main
  ```

  This command should remove the existing Git history, initialize a new Git repository, add your forked repository as the remote named `origin`, fetch the data from it, and reset the local files to match the `main` branch of your forked repository. After running the above commands, open the Source Control view in Visual Studio Code and commit any local changes. This will create a commit that points to your forked repository. In the terminal you can push the commit to GitHub with:

  ```bash
  git push -u origin main
  ```

  If you're unsure that you're connected to the correct repository, check the remote with:

  ```bash
  git remote -v
  ```

  This should show the URL of your forked repository (`https://github.com/YOUR-USERNAME/union_shop.git` where `YOUR-USERNAME` is your GitHub username).

**University Computers:**

- Open [AppsAnywhere](https://appsanywhere.port.ac.uk/sso) and launch the following in the given order:
  - Git
  - Flutter And Dart SDK
  - Visual Studio Code

**Personal Windows Computer:**

- Install [Chocolatey package manager](https://chocolatey.org/install)
- Run in PowerShell (as Administrator):

  ```bash
  choco install git vscode flutter -y
  ```

**Personal macOS Computer:**

- Install [Homebrew package manager](https://brew.sh/)
- Run in Terminal:

  ```bash
  brew install --cask visual-studio-code flutter
  ```

After installation, verify your setup by running:

```bash
flutter doctor
```

This command checks your environment and displays a report of the status of your Flutter installation.

For detailed step-by-step instructions, refer to [Worksheet 1 — Introduction to Flutter](https://manighahrmani.github.io/sandwich_shop/worksheet-1.html), which covers the complete setup process for all three options.

### Fork the Repository

Go to the repository containing the code for the coursework and click on the fork button as shown in the screenshot: [github.com/manighahrmani/union_shop/fork](https://github.com/manighahrmani/union_shop/fork) (Alternatively, just use this link: [github.com/manighahrmani/union_shop/fork](https://github.com/manighahrmani/union_shop/fork).)

![Fork Button](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_fork_button.png)

Do not change anything and click on the Create fork button. You should then have a public fork of my repository with a URL like (YOUR-USERNAME replaced with your username): [github.com/YOUR-USERNAME/union_shop](https://github.com/YOUR-USERNAME/union_shop)

![Fork Settings](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_fork_settings.png)

Note that the name of this created fork must be “union_shop”. If you already have a repository with this name, you need to rename it beforehand.

### Clone Your Forked Repository

If you are using Firebase, access idx.google.com with a personal Google account. Create a new Flutter Workspace named `union_shop` (choose the Flutter template in the “Start coding an app” section). Once the Flutter Workspace is created, open the integrated terminal (View → Terminal) and link this project to your forked GitHub repository by running the following commands (replace YOUR-USERNAME in the URL): 

```bash
rm -rf .git && git init && git remote add origin https://github.com/YOUR-USERNAME/union_shop.git && git fetch origin && git reset --hard origin/main 
```

This command should remove the existing Git history, initialize a new Git repository, add your forked repository as the remote named origin, fetch the data from it. It should also reset the local files to match the main branch of your forked repository. After running the above commands, open the Source Control view and commit any local changes.  

Otherwise, open a terminal, change to your desired directory, and run the following commands:

```bash
git clone https://github.com/YOUR-USERNAME/union_shop.git
cd union_shop
```

Replace `YOUR-USERNAME` with your actual GitHub username.

### Install Dependencies

Your editor should automatically prompt you to install the required dependencies when you open the project. If not, open the integrated terminal (open the Command Palette with `Ctrl+Shift+P` or `Cmd+Shift+P` and type "Terminal: Create New Terminal") and run the following command:

```bash
flutter pub get
```

### Run the Application

This application is primarily designed to run on the **web** and should be viewed in **mobile view** using your browser's developer tools. We recommend using Google Chrome.

Select Chrome as the target device and run the application either from the `main.dart` file or by entering the following command in the terminal:

```bash
flutter run -d chrome
```

Once the app is running in Chrome, open Chrome DevTools by right-clicking on the page and selecting "Inspect" (or use the shortcut `F12`). Click the "Toggle device toolbar" button as shown in the screenshot below.

![Chrome DevTools Mobile View](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_chrome_devtools.png)

From the Dimensions menu, select a mobile device preset (e.g., iPhone 12 Pro, Pixel 5):

![Device Selection](https://raw.githubusercontent.com/manighahrmani/sandwich_shop/refs/heads/main/images/screenshot_chrome_devtools_device_selection.png)

## Marking Criteria

This assessment is worth 55% of the marks for the module's assessment item 1 (the remaining 45% comes from the weekly sign-offs). The mark for the assessment is divided into two components:


# Union Shop — Coursework (Assessment-ready README)

This README replaces the starter README and is written to help you meet the **Software Development Practices (25%)** marking criteria and to make it straightforward to run, test and submit the app.

## What this repository contains

- `lib/main.dart` — homepage and routes
- `lib/product_page.dart` — a simple product details page
- `test/` — widget tests shipped with the starter
- `pubspec.yaml` — dependencies

If you forked this repo for the coursework, continue working in your fork and submit the fork URL on Moodle before the deadline.

## Quick start — run locally (tested on Windows PowerShell)

1. Install Flutter and tooling. Verify with:

```powershell
flutter doctor
```

2. Get dependencies:

```powershell
flutter pub get
```

3. Run the app in Chrome (recommended for mobile view emulation):

```powershell
flutter run -d chrome
```

Open DevTools (F12) and toggle device toolbar to simulate a mobile screen.

## Tests

Run widget tests shipped in `test/` with:

```powershell
flutter test
```

Make sure tests pass before submitting. Aim to add more tests as you implement features.

## Marking checklist (short)

This maps the marking criteria to concrete actions you can take in the repo. Use it as a checklist when preparing for demo and submission.

- Application (30% demonstrated in the demo): implement features from the marking table (homepage, collections, product pages, cart, authentication UI, responsiveness). Prioritise "Basic" features first.
- Software dev practices (25% assessed from repository):
  - Git (8%): regular, small, meaningful commits with clear messages — e.g., `feat: add product model` or `test: add product page tests`.
  - README (5%): this file documents run steps, tests, external services, and submission checklist.
  - Testing (6%): include widget/unit tests and keep them passing.
  - External services (6%): integrate at least two cloud services (e.g., Firebase Auth + Firestore, or Firebase Storage + Firebase Hosting). Document the setup clearly in this README.

## Submission & demo checklist

Before the demo/assessment make sure you have done the following and can perform each step from a fresh clone:

1. Push your work to your public fork `https://github.com/YOUR-USERNAME/union_shop`.
2. On Moodle paste the URL of your fork in the submission field for Item 1 (before the deadline).
3. Ensure `flutter pub get` and `flutter run -d chrome` work from a fresh clone.
4. Tests: `flutter test` should pass.
5. Prepare a 10-minute demo script showing the features you implemented and where they map to the marking table.

Failure to attend the practical demo or to submit the fork URL on Moodle will result in 0 marks for the coursework.

## External services (document here if used)

If you integrate external services include the following information in this README:

- Service provider (e.g., Firebase)
- Which features use it (Auth, Firestore, Storage, Hosting)
- Short setup notes (how to configure `google-services.json` / `GoogleService-Info.plist` or environment variables)
- A public link if hosted

Example (to copy & adapt):

```
Service: Firebase
Used for: Authentication (email/password) and Firestore to store products and cart data
Notes: add your `web` Firebase config in `lib/firebase_options.dart` (do not commit secrets)
```

You must integrate at least two separate external services to claim the "External Services" marks. Document them here.

## Git & commit guidance

- Commit early and often. Each commit should be a small logical unit.
- Use meaningful messages: `feat: add collections page`, `fix: correct product price formatting`, `test: add product card tests`.
- Create branches for large features and merge via pull requests where possible.

Example minimal workflow (PowerShell):

```powershell
git checkout -b feat/collections
git add .
git commit -m "feat: add collections screen with hardcoded data"
git push -u origin feat/collections
```

## Continuous integration (recommended)

Add a simple GitHub Actions workflow to run `flutter analyze` and `flutter test` on push/PR. This is optional but improves the "software development practices" evidence.

## Notes for assessors (optional)

If you are the student submitting this repository, use the demo to highlight which features you implemented and where in the code they live (file paths and commit history). Provide any hosting links or service credentials required to view live functionality.

## Next steps I can help with

- Add a concise `.github/workflows/flutter-ci.yml` that runs `flutter analyze` and `flutter test` on each push.
- Add/extend widget tests covering homepage and product pages.
- Integrate Firebase (Auth + Firestore) and document the setup in this README.

If you want me to proceed with any of the above, tell me which one and I'll implement it.

---

Last updated: 2025-12-01
