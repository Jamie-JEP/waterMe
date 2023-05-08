###### git push trial

# WaterMe
2023-1 Human Computer Interaction Team Project

Team number: 6

Team members: Choi Changyu, Choi Minyeong, An Hyebin,
Kim Minkyung, Park Jungeun, Song Juhyeon

used Tools: Arduino Uno, 

## Title
The app that helps you manage plants easily considering the characteristics of each plant.

## Abstract
Most people grow plants at home that provide air purification and psychological stability, along with the popularity of "Planterior" which combines interior design and plant cultivation. However, many people struggle to care for their plants properly, leading to a demand for smart plant systems. Our proposed solution is a detachable device that connects to sensors and a database to monitor and provide information on a plant's moisture, temperature, and light levels via a mobile application, helping users maintain healthy plants.

## Problems
1. Limitations and Improvement Measures of Smart Planters 
Sales of plant-related tools have increased as the COVID-19 pandemic has increased time spent at home. Among them, smart planters have the advantage of making it more convenient for users to manage plants by utilizing automated functions and smart technology. However, users may feel uncomfortable due to limitations such as the complex interface, high price, large size, and unstable Internet connection of smart planters. Therefore, the development and research of new smart planters that provide user-friendly interfaces and reliable Internet connections are needed.


2. The importance of various plant types and individual plant management
Plant management should set optimal conditions considering various environmental factors and plant growth conditions. Each plant needs proper care to suit its characteristics. To do this, users should learn the characteristics of their plants and how to manage them best. Furthermore, since conventional plant care advice may not be appropriate for all plant species, it is more effective for users to receive individual plant care services. This makes it easier and more convenient for users to manage plants. 

3. Design improvement
Design improvements are needed to increase user satisfaction. 

## Solution
Our ultimate goal is to create an app that can help us to manage plants that can be integrated with a mobile application to collect and analyze plant growth data, allowing users to track their plants' health and receive alerts when action is needed, such as watering. The final product will consist of the smart plant sensor and mobile application. It will make it easy for users to manage a variety of plants and provide a user-friendly service. Essentially, it will provide users with more efficient, easy, and detailed information when growing plants. This will enable users to keep their plants healthier and improve their quality of life. Since the plant pot and sensors are detachable, it can be used to grow a variety of plants regardless of the pot size.

The solution will involve connecting soil moisture sensors, temperature and humidity sensors and measuring the plant's environmental data. The measured data will be stored in a database (DB) in real-time through WiFi. Since the sensors are separate from the main body, users can easily use them on any plant they want. The environmental data (soil moisture, temperature and humidity, and light intensity) measured by the sensors will be sent to the DB and the user can check this data in real-time through the mobile application.

The mobile application will deliver real-time environmental data to the user, allowing them to see the plant's status anytime and anywhere. In addition, the watering time will be saved in the DB and the 10 most recent watering times will be provided to the user, which can help users manage their plants better. When the user registers a plant, the app will provide information on the plant's growth environment, making it easier for the user to manage it by providing customized cultivation instructions based on the plant's characteristics, such as reminders to water it or to place it in a sunny or well-ventilated area. In summary, the smart plant pot and mobile application will make it easy and efficient for users to grow plants and keep them healthy.

## Main Function
-Based on the plant soil humidity measurement data, the app notifies users to water the plant when it is low in humidity for soil, and to water less if it is high in humidity for soil. 

-Reflecting the watering cycle of each plant, notify when the water cycle approaches.

-After plant registration, basic information (characteristics) is provided in the UI for easy viewing. 

-Recommended for plant movement when surrounding temperature is too high.

-Show the day you recently watered plant on user calendar.
