const AWS = require('aws-sdk');
const bedrock = new AWS.BedrockRuntime({ region: 'us-east-1' });

exports.handler = async (event) => {
    const medicineName = event.request?.intent?.slots?.Medicine?.value || event.medicine || "Panadol";

    const prompt = `You are MediScan health assistant for elderly in Pakistan.
    Explain medicine ${medicineName} in simple Urdu and English for Alexa+ voice:
    1. Use for
    2. Dosage
    3. Side effects
    4. Expiry warning if expired
    Keep answer under 60 words, simple language.`;

    const params = {
        modelId: 'anthropic.claude-3-sonnet-20240229-v1:0',
        contentType: 'application/json',
        accept: 'application/json',
        body: JSON.stringify({
            anthropic_version: "bedrock-2023-05-31",
            max_tokens: 500,
            messages: [{ role: "user", content: prompt }]
        })
    };

    let speechText = `${medicineName} is used for fever and pain. Take 1 tablet after meal. Check expiry before use.`;

    try {
        const response = await bedrock.invokeModel(params).promise();
        const result = JSON.parse(response.body.toString());
        if(result.content && result.content[0]) {
            speechText = result.content[0].text;
        }
    } catch (e) {
        console.log("Bedrock error, using fallback:", e);
    }

    // Alexa+ Response Format
    return {
        version: '1.0',
        response: {
            outputSpeech: {
                type: 'SSML',
                ssml: `<speak>${speechText} <break time="500ms"/> Displayed on your Fire TV as well.</speak>`
            },
            card: {
                type: 'Standard',
                title: `MediScan - ${medicineName}`,
                text: speechText,
                image: {
                    smallImageUrl: 'https://example.com/medicine-720x480.png',
                    largeImageUrl: 'https://example.com/medicine-1200x800.png'
                }
            },
            directives: [
                {
                    type: 'Alexa.Presentation.APL.RenderDocument',
                    document: {
                        type: 'APL',
                        version: '1.8',
                        mainTemplate: {
                            items: [
                                {
                                    type: 'Text',
                                    text: `${medicineName}: ${speechText}`,
                                    fontSize: '24dp'
                                }
                            ]
                        }
                    }
                }
            ],
            shouldEndSession: false
        }
    };
};
File name: `lambda/index.js
