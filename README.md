# iOS movies

Simple movie app integrate with themoviedb.org

## List Movies screen
- Infinite scroll to show movies

## Details Movie screen
- Details view about the movie and cast
- Custom View for cast
- Custom previews to show screen and custom components
- Extract dominant color from movie image and set dominant color
for components

To run this project you need create API key in themoviedb.org, create Config.plist and add a key "ApiKey" with the value.
If you don't want create Config.plist, make function getApiKey in LocalProperties class return apikey that you created.

https://github.com/LuizGadao/iOSMovies/assets/3384999/f8369624-d07a-406c-8b02-85d0fb69931e

Screens :

![list movies](https://github.com/LuizGadao/iOSMovies/blob/develop/files/mov_img_2.png?raw=true)
![details movi](https://github.com/LuizGadao/iOSMovies/blob/develop/files/mov_img_1.png?raw=true)


### Todo

- mvvm architecture
- unit tests
