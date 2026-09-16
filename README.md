
# MediScan - AI Medicine Scanner for Alexa+ and Fire TV

> Alexa, scan my medicine and tell me if it's safe.

MediScan helps elderly and visually impaired users identify medicines, check drug interactions, and get dosage guidance using Alexa+ and Fire TV.

## Problem
People struggle to read medicine labels leading to wrong dosage and dangerous interactions.

## Solution
- Flutter App: Scan medicine with camera, AI reads name, expiry, dosage using ML Kit + Gemini AI
- Alexa+ Skill: Ask "Is Aspirin safe with my diabetes medicine?" Alexa checks history and warns
- Fire TV App: Large text display for elderly on TV
- AWS Lambda: Secure serverless API

## Tech Stack
Flutter, Alexa Skills Kit, AWS Lambda, DynamoDB, S3, Google ML Kit, Gemini AI

## Features
1. Instant Medicine Scan
2. Drug Interaction Checker
3. Voice Reminders via Alexa
4. Family Care Mode
5. Hindi, Urdu, English Support

## How to Run
flutter pub get
flutter run

## Alexa Skill
Endpoint: AWS Lambda - mediscan-alexa-handler

## Built for Alexa & Fire TV Hackathon
Team AliSeekhAi

## License MIT
