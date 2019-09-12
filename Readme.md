Our fictional startup is building a product to help people keep track on what they’re spending their money on. To do so, we’ll build an iPhone app that list all the places where they’ve made purchases, giving them the option to inspect what items were purchased on each place.

The app should roughly look like the following image. Please use default controls, with default settings (font/size/colour), except for the annotated elements (amount indicator and total).

The user’s expenses list should be downloaded from here and stored locally. The feed has the following format:

```json
[
 {
 "date": "2018–03–23T13:12:46.404",
 "shop": "Jerry's Deli",
 "paid": "20",
 "payment_type": "card",
 "items": [
 {
 "item": "cheese",
 "ean": 5417684009468,
 "price": 1.20
 },
 {
 "item": "cheese",
 "ean": 5417684009468,
 "price": 1.20
 }
 ]
 }
]
```

Dos and don’ts:

* the app should be built using native tools, Swift/Obj-C (no cross-platform frameworks like ReactNative, Xamarin, etc)

* you’re free to use any (external) library (networking, storage, etc), except for RxSwift, React* and friends.

* for source control, please use git, having as many commits as necessary. Idealy, there should be more than two commits.

* we’ll be checking for good app practicies (e.g. app was not developed in one file, no priceLabel.text = json[“item”].price)
