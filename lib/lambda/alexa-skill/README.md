# MediScan - Alexa+ Health Companion

AI Medicine Scanner for elderly & visually impaired - built for Alexa+ & Fire TV.

### Problem
Elderly in Pakistan cannot read medicine expiry, dosage. Risk of wrong medicine.

### Solution
- Flutter App scans medicine with OCR (google_mlkit)
- TTS speaks info in Urdu/English
- Alexa+ Skill: "Alexa, ask Medi Scan what is Panadol"
- Fire TV displays large text for family
- AWS Lambda + Bedrock for AI explanation

### Tech Stack
Flutter, AWS Lambda, Alexa+, Amazon Bedrock, Fire TV, Echo Show

### How it Works
1. User scans medicine strip
2. OCR extracts text
3. Lambda calls Bedrock: dosage, side-effects, expiry
4. Result shown on Phone, Fire TV, and spoken by Alexa+

### Future
Full integration with Amazon Pharmacy, reminders.

Built for Amazon Hackathon 2025 - Alexa+ Track
