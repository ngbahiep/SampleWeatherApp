# SampleWeatherApp

## Brief explanation for the software development principles, patterns & practices being applied:
1. This is a sample app to display weather information of specific city. User is required to key in city name where he/she wants to search the weather information into search field.
2. Weather information is gotten from openweathermap.org
3. Since user finished key  in city name in search textfield, 1 second later, app will start requesting weather information. It helps to prevent the app from generating a bunch of API requests. 
4. Following is patterns & practices being applied:
- Architectural pattern: MVVM
- Use Alamorefire for making network requests.
- Support Accessibility.
- Applied Unit test for testing ViewModel object.

## Brief explanation for the code folder structure and the key libraries and frameworks being used
1. Following is code folder structure:
- ThirdParty: Place to contain libraries and frameworks being used.
- Model: Place to contain model objects, eg: Weather.
- View: Place to contain views, eg: WeatherTableViewCell.
- ViewModel: Place to containt ViewModel objects, eg: WeatherViewModel.
- Controllers: Place to contains controllers, eg: ViewController.
2. Libraries and frameworks being used:
- Alamofire: for making network requests.
- Progress: To display progress view while waiting for response from server

## All the required steps in order to get the application run on local computer
- Open up Terminal, cd into directory you want to download the source code, and run the following command:
```bash
git clone https://github.com/ngbahiep/SampleWeatherApp.git
```
- cd into SampleWeatherApp 
```bash
cd SampleWeatherApp
```
- Add Alamofire as a git submodule by running the following command:
```bash
git submodule add https://github.com/Alamofire/Alamofire.git
```
- Open SampleWeatherApp.xcodeproj and run the project
