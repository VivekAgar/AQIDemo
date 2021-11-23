# AQIDemo

## What is it?
A demo project with VIPER architecture. All views, Interactors Presenter and routers are in place with their respective folder.
Application connects to a web socket for latest AQI data.

 App provides live AQI data values for cities on listing and detail page.
 on detail page we can see historical data of last 30 minutes and last 1 hour (if data is available in local sqllite db )
 we need to allow app to run for some time so that app can store data to show historical data.



## App Flow 
on launch in Scenedelegate router object is created and app flow starts.
Interactor connects to websocket using a library Starscream.

on receiving data from socket presenter update values based upon cities in a array.with this array presenteralways provides latest data  to views.
on every 30 seconds presenter stores latest data to a local sqllite db.

## Screenshots 

![Simulator Screen Shot - iPhone 11 - 2021-11-23 at 10 06 06](https://user-images.githubusercontent.com/20533088/142973806-4865de5a-562d-4015-9c3f-d5a620d20e92.png)

![Simulator Screen Shot - iPhone 11 - 2021-11-23 at 10 06 29](https://user-images.githubusercontent.com/20533088/142973822-82c24539-c00a-4522-a6a2-8f80acfbaad7.png)

![Simulator Screen Shot - iPhone 11 - 2021-11-23 at 10 06 34](https://user-images.githubusercontent.com/20533088/142973965-7a0283ff-0c5d-474f-97fe-c75e38643216.png)



## Libraries used : 

	pod 'Charts'
	pod 'Starscream', '~> 4.0.0'

### Use of Charts :
Used Chart library to show data in bar charts.

### Use of Starscream :
Used Starscream to connect websocket, library simplifies connection to a websocket.

### Improved performance : 
Performance improvement is done in write operation of sqllite where inserted a bunch of records in one go, instead of individual insert operation.

### Gradient view For AQI :
Designed a AQIGradientView with colors of AQI and values , similar to we see in default weather app in ios 15.

### Dark Mode support :
App support both light and dark modes.

## How to run
git checkout and open project in xcode.
