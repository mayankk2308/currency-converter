# Currency Converter

The Currency Converter iOS app is a simple, fast, and efficient way of converting currency from USD to INR, EUR, & GBP. The app also features ‘Associations’, allowing users to associate their conversions for future reference. The conversion interface is the initial view of the app, in the Convert tab. The app stores saved conversions along with its associations and displays them in the History tab.

## About The App
**Convert**: Converting currencies has never been simpler. Just type in a few digits (a USD amount) using the built-in app keypad, and voila, you have conversions in real-time, as you type. The app maintains a simple UI across all its views, so everything is crystal clear, always.

**Conversion Rates**: Users need not worry about conversion rates, since the latest rates are automatically fetched before a user makes a conversion. The app includes a Refresh button to fetch the most recent rates from the currencylayer API. Do not have internet? No worries. The app automatically defaults to the last used conversion rates, so users can utilize the most recent conversion rate for conversions. If the app has no access to the internet on first launch, conversion rates will default to those on July 27, 2015. This will automatically be updated when the app connects to the internet and the user refreshes, or on the next launch.

**Associations**: If users choose to save a conversion, a modal view will be presented that will allow them to add associations using a text field to this conversion. For example, a user could associate 1.25$ with a can of ‘Coke’. Users may choose not to add associations by simply proceeding and saving. The app then saves the complete conversion data.

**Conversion History**: Users can browse their past conversions in the History tab in a detailed table view. Each conversion is completely listed with its values and associations. On selecting a conversion in the history view, users will be directed to the Detail view. Users can always return to the Convert tab to save more conversions.

**Detail View**: This view displays the selected conversion’s base value and its associations. Users can choose to edit or add existing associations, or remove associations. The view also provides for a Delete option which deletes the conversion from the history view (and on disk).

**Alerts**: Having problems fetching the latest conversion rates? No worries. The app will present an alert letting you know exactly what the problem is (whether its your internet, or the API server, or something else), and tell you what steps the app is taking as a contingency option.

## Technical
* API - Currencylayer (free account)
* Persistence Techniques - NSUserDefaults (for previous rates)
* Core Data (conversion data)
* UIControl Aspects - UIButtons, UITextfields, & UIActivityIndicators
* UIView Types - Simple Views, Tab Bar Controller, Navigation Controller, Table View Controller , & Custom Table Cell

## Motivation
As an international student at a US university, I have always had the urge to convert from USD to my local currency on-the-fly and not worry about any conversion rates, etc. Currency Converter is just the app I wanted - a simple super-quick solution - being the light app it is. On top of that, adding associations to my conversions makes it awesome for future reference and comparisons!
