# BuildingMaintenanceHackathon

## We have attended 48 hours hackathon organised by Honeywell, and below is the outcome.

An iOS app that gives directions from point to point using augmented reality and chat support using the Chatbots using NLP.



## System Architecture

<img width="1116" alt="screen shot 2018-07-28 at 11 50 32 am" src="https://user-images.githubusercontent.com/8708394/43353730-8d741ccc-925c-11e8-9975-47be3ace9afe.png">


## What problem we tried to solve.

1. DIY support for Installer and Maintenance Technicians
2. Real time report of the current state of the equipment 
3. Minimizing the error rate of misconfigurations
4. Minimizing the dependency on the OEM help. 


## How do we solve

1. Verification of the installed component with reference data of the OEM
2. Verification process report the status of the configured attributes (qualified/not qualified)
3. For “not qualified” the CHATBOT option is provided as DIY support. 
4. CHATBOT will assist with suggested solutions
5. CHATBOT will provide the options of installation video links and the installation guides.
6. AR will provide the direction to the installer to reach to the not qualified equipment from his current location.

## Backend is supported with -

1. Google Functions and API
2. Firebase
3. NOSQL
4. Kafka

## Frontend is supported with -

1. iOS application. [iOS 11.0+]


## iOS Framework used -

1. ApiAI - For Google Dialogflow.
2. IQKeyboardManagerSwift - For Managing Keyboard.
3. JSQMessagesViewController - For building Chat.
4. ARCL & CocoaLumberjack/Swift - For Augmented Reality.

## Download it and check it in your phone, but it must support > iOS 11.0.

P.S. - 

1. As it's a 48 hours hackathon, Code quality and structure isn't maintained properly. :)
2. Lat, Long's are hardcoded in the ARViewController, add your current lat long's to see the Augmented Reality view.



