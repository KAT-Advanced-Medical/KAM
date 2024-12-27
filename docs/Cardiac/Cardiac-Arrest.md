# Cardiac Arrest

Cardiac arrest occurs when someone reaches one of the below critical values in either their HR or their BP. This will cause the player to fall unconscious, stopping their breathing and heart rate.

**Critical Values:**
- < 20 or > 220 BPM
- > 285 / 190 mmHg
- < 50 / 40 mmHg (If HR is < 40 BPM)
- Between 20 - 30 BPM (random chance)

## Heart Rhythms

![four-rhythms](https://private-user-images.githubusercontent.com/15182031/253309068-b8e88392-2b1e-4a9d-a454-45f1a09c9940.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTY1OTQ4ODcsIm5iZiI6MTcxNjU5NDU4NywicGF0aCI6Ii8xNTE4MjAzMS8yNTMzMDkwNjgtYjhlODgzOTItMmIxZS00YTlkLWE0NTQtNDVmMWEwOWM5OTQwLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNDA1MjQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjQwNTI0VDIzNDk0N1omWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTIxZGY2YzUwNmU5ZGFhOGYyMjQ1MmMwMjYyZjE5MDYwMWU4MDZiOWNlMzYwYWYyOTVhMmMyMDVkOTc4MTQ5NjgmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.-loI59Zwjzs0SgPPD1QNU-ty9aKQ5cvu3KNZpvYKNNg)
*Graph showing the five different heart rhythms and how the game switches between them*

There are five types of heart rhythms, four of which cause cardiac arrest. They typically fall into two categories: [Shockable Rhythms](/Cardiac/Shockable-Rhythms.md) & [Non-Shockable Rhythms](/Cardiac/Non-Shockable-Rhythms.md). 

### Diagnosing Heart Rhythm

The most important step to maximize the probability of patient recovery is properly diagnosing the type of cardiac arrest in order to begin the proper course of treatment. The best way to do that is to use the EKG feature on the [AED-X](/Equipment/AED-X.md). Once you do that, you will see one of the below EKG values:

| Description                                                                                            | Value                                                                                                                                                                                                      |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Ventricular Tachycardia (VT)](/Cardiac/Shockable-Rhythms.md#ventricular-tachycardia)                  | ![vTac](https://lh7-us.googleusercontent.com/Q8XcJzafKjUx1Xii46O3gNAiVlYcQcPXiG4L9FIzjUNyTD7KlM87XlDWGEHhRHmcvdxNjwDTpF9smKbt0V--8tv6E_hsgy16UkqUpfnEtTcv7VQfxtz4O-Y5M-WmBmu7UN4x1i2SR8tk_VoAT4jvVfc)      |
| [Ventricular Fibrillation (VF)](/Cardiac/Shockable-Rhythms.md#ventricular-fibrillation)                | ![vFib](https://lh7-us.googleusercontent.com/X2VSjZjR-3utt8pGzhumf3XJ-lLb0EShSjcMYiUV6asDBM2pMVNN868N_Xd3ryfXsZY54eh83f9sv9BuSVv14LlYRqSS6z-vrSQaFwiaUI-Th4PJgqSQVoClCpx5oTPUrMN1e3WCaA2skfFbJeybL8U)      |
| [Pulseless Electrical Activity (PEA)](/Cardiac/Non-Shockable-Rhythms.md#pulseless-electrical-activity) | ![pea](https://lh7-us.googleusercontent.com/aQcmPZ5sLqjiZElM-a9_VbQavun5chOkCAHu0sVTMOT2kH0gbkis-Ivh6NEH1vKUB3BFAHkbju_R4lJyaI9peDP5E5PjAbNxmeaXQ9b02ZzwFWpMvy4TGcKa00g2pJtn9Ur6NJxt8cpE63HzzIRTDzo)       |
| [Asystole](/Cardiac/Non-Shockable-Rhythms.md#asystole)                                                 | ![asystole](https://lh7-us.googleusercontent.com/LnB3GRgUu3x15snlClUudRRHaNf-gSfED1UFvY8TssQPWaUgTHhImLYItigdm_abnyPdbDQMuJDGl928O_BS48RD23tCtHdya9yQLshdYkjqU3ox9z14-x5FyRSk8h4d6M8rZ1wMHJvT3QqtjRZ_oYM)  |
| CPR                                                                                                    | ![cpr](https://lh7-us.googleusercontent.com/JQh-n7mVpPP2MogpcwXowrKtA0fdqPofUt4JPoaeLIZMH4AN-amWkGjiA1Wj8wd8AzxMMeX9H8iTxWKwjrWW4Gm5tR5VPvBg53zLT1ASwimN3M12PeILYNeamJ8hvIgzPpbe1UKrzfik5s-CgVcA8K0)       |
| AED pads not connected                                                                                 | ![aed-error](https://lh7-us.googleusercontent.com/LxdkmO9nirIp8xo3LxBYdxrNCHG4HjO7LzPI5veoEM7sI_6LIrpSLegUJ074rhgoeIQTrDiebR6QFi86DYaxfQwuBOLz7tYbIODkqNNY1mqr6MAbR0vMv49UCzX4xam72e48C2dvvw815XvOqi8gGTE) |
>[!NOTE]
>PEA has the same EKG readout as a normal sinus rhythm. 

If you don't have an AED-X, you can also use the "Analyze Rhythm" feature on the [AED](/Equipment/AED). That will tell you if it is a shockable or non-shockable rhythm.

