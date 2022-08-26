# MitX

## Localization
* first create class implements Translations

```dart
 class LangController implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
            'test':'test',
        }
        'ar': {
            'test':'تست',
        }
      };
}
```
* second call it in MitXMaterialApp

```dart
 MitXMaterialApp(
    translations: LangController(),
    locale: Locale('en', 'US'), // translations will be displayed in that locale
    fallbackLocale: Locale('en', 'UK'), // specify the fallback locale in case an invalid locale is selected.
 );
```

## Using translations
* Just append .tr to the specified key and it will be translated, using the current value of MitX.locale and MitX.fallbackLocale.

```dart
    Text('test'.tr)
```
* Using translation with singular and plural

```dart
   var products = [];
   Text('singularKey'.trPlural('pluralKey', products.length, Args));
```

* Using translation with parameters

```dart
   import 'package:get/get.dart';


Map<String, Map<String, String>> get keys => {
    'en_US': {
        'logged_in': 'logged in as @name with email @email',
    },
    'es_ES': {
       'logged_in': 'iniciado sesión como @name con e-mail @email',
    }
};

Text('logged_in'.trParams({
  'name': 'Jhon',
  'email': 'jhon@example.com'
  }));
```

# Locales
* Pass parameters to MitXMaterialApp to define the locale and translations.

## Change locale

* Call MitX.updateLocale(locale) to update the locale. Translations then automatically use the new locale.

``` dart
    var locale = Locale('en', 'US');
    MitX.updateLocale(locale);
```

## System locale

* To read the system locale, you could use MitX.deviceLocale.

```dart
   return MitXMaterialApp(
    locale: MitX.deviceLocale,
);
```


## Route management

to navigate or generate navigation 

* in flutter 

```dart
    MaterialPageRoute(builder: (context) => const HomeView());
```

* but now you can use it with the same parameters

```dart
     mitXMaterialPageRoute(page: const FiveDaysForecastView());
```

If you are going to use routes/snackbars/dialogs/bottomsheets without context, MitXX is excellent for you too, just see it:


```dart
MitXMaterialApp( // not needed MaterialApp 
  home: MyHome(),
)
```

Navigate to a new screen:

```dart

MitX.to(NextScreen());
```

Navigate to new screen with name. See more details on named routes [here](./documentation/en_US/route_management.md#navigation-with-named-routes)

```dart

MitX.toNamed('/details');
```

To close snackbars, dialogs, bottomsheets, or anything you would normally close with Navigator.pop(context);

```dart
MitX.back();
```

To go to the next screen and no option to go back to the previous screen (for use in SplashScreens, login screens, etc.)

```dart
MitX.off(NextScreen());
```

To go to the next screen and cancel all previous routes (useful in shopping carts, polls, and tests)

```dart
MitX.offAll(NextScreen());
```

Noticed that you didn't have to use context to do any of these things? That's one of the biggest advantages of using MitX route management. With this, you can execute all these methods from within your controller class, without worries.

### More details about route management


on your controller/bloc/stateful/stateless class:

```dart
print(MitX.parameters['id']);
// out: 187
print(MitX.parameters['name']);
// out: MitX
```

d data on route name

```dart
MitX.toNamed("/profile/34954");
```

On second screen take the data by parameter

```dart
print(MitX.parameters['user']);
// out: 34954
```

or send multiple parameters like this

```dart
MitX.toNamed("/profile/34954?flag=true&country=italy");
```
or
```dart
var parameters = <String, String>{"flag": "true","country": "italy",};
MitX.toNamed("/profile/34954", parameters: parameters);
```

On second screen take the data by parameters as usually

```dart
print(MitX.parameters['user']);
print(MitX.parameters['flag']);
print(MitX.parameters['country']);
// out: 34954 true italy
```


## Navigation without context

### SnackBars

To have a simple SnackBar with Flutter, you must get the context of Scaffold, or you must use a GlobalKey attached to your Scaffold

```dart
final snackBar = SnackBar(
  content: Text('Hi!'),
  action: SnackBarAction(
    label: 'I am a old and ugly snackbar :(',
    onPressed: (){}
  ),
);
// Find the Scaffold in the widget tree and use
// it to show a SnackBar.
Scaffold.of(context).showSnackBar(snackBar);
```

With MitX_X:

```dart
   MitX.showSnackbar(MitXSnackBar());
   //or
   MitX.snackbar('title', 'message');

```

If you prefer the traditional snackbar, or want to customize it from scratch, including adding just one line (MitX.snackbar makes use of a mandatory title and message), you can use
`MitX.rawSnackbar();` which provides the RAW API on which MitX.snackbar was built.

### Dialogs

To open dialog:

```dart
MitX.dialog(YourDialogWidget());
```

To open default dialog:

```dart
MitX.defaultDialog(
  onConfirm: () => print("Ok"),
  middleText: "Dialog made in 3 lines of code"
);
```

You can also use MitX.generalDialog instead of showGeneralDialog.

For all other Flutter dialog widgets, including cupertinos, you can use MitX.overlayContext instead of context, and open it anywhere in your code.
For widgets that don't use Overlay, you can use MitX.context.
These two contexts will work in 99% of cases to replace the context of your UI, except for cases where inheritedWidget is used without a navigation context.

### BottomSheets

MitX.bottomSheet is like showModalBottomSheet, but don't need of context.



## Change Theme

Please do not use any higher level widget than `MitXMaterialApp` in order to update it. This can trigger duplicate keys. A lot of people are used to the prehistoric approach of creating a "ThemeProvider" widget just to change the theme of your app, and this is definitely NOT necessary with **MitX_X™**.

You can create your custom theme and simply add it within `MitX.changeTheme` without any boilerplate for that:

```dart
MitX.changeTheme(ThemeData.light());
```

If you want to create something like a button that changes the Theme in `onTap`, you can combine two **MitX_X™** APIs for that:

- The api that checks if the dark `Theme` is being used.
- And the `Theme` Change API, you can just put this within an `onPressed`:

```dart
MitX.changeTheme(MitX.isDarkMode? ThemeData.light(): ThemeData.dark());
```

When `.darkmode` is activated, it will switch to the _light theme_, and when the _light theme_ becomes active, it will change to _dark theme_.
