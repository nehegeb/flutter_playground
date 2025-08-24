# Languages and Localization

*TLDR: The Flutter Framework Core supports multiple languages. If there are more than one language defined, a language selector will be available within the app. The default app language can be changed to whatever you like. New languages can be added easily.*

The Flutter Framework Core supports multiple languages the user can select within the app. If there are more than one language defined within the `languages.json` file, a language selector will be available at the top right within the app. All localized texts displayed in the app will update instantly upon selecting a new language. The initial language the user sees will be the one their browser is set to, if the app supports it. If not, it'll always fall back to the apps default language (see below). After that the language selected by the user will be stored to the users local storage using `[LocalCache]` and loaded when that user opens the app again (on the same device).

The Flutter Framework Core uses one language as default and fallback (you can define which one it is, see below). This default language is always loaded for fallback purposes. If another language than the default one is selected by the user within the app, it'll automatically always load the localization data of your default language as well as the localization data for the selected language. If anything cannot be translated into that selected language, it'll always fall back to the corresponding localization of the default language.

Why should something not be able to translate? That's most certainly because that localization key isn't present within the localization file of the selected language. If there's a key for that localization present in the localization data for the default language, it'll use that one instead. And if no such key is present in the localization file of the default language, it'll always display `[NO_LOCALIZATION]` in its place. So no error should occur during runtime.

## The `app/localization/data/` folder

This folder holds all languages and localization data for the whole app. The `languages.json` might be moved to a proper database if need be. For the localization data I would recommend keeping it as JSON files within this folder.

All localization data file names must have this structure: `localization_<languageID>.json`

## Choosing the default and fallback language of the app

*I would recommend sticking to English as the default language, as it is the most used worldwide. But you can choose whatever you like.*

At the very top of the file `app/localization/localization.dart` you'll find the variable `defaultLanguageId` which determines the default and fallback language of the app. Just change that language ID to any one you like.

NOTE: There has to exist a localization file corresponding to the default language ID! For English it would be the language ID `en` with the localization file `app/localization/data/localization_en.json`. If no such file exists, there'll be an error while launching the app!

## How to add a new language

All localization files are stored in the folder `app/localization/data/`.

Open the file `languages.json`. Duplicate the JSON tree for the apps default language and adjust the values for the new language (see below).

Then duplicate the localization file of your default language and rename it with the language ID you chose for `defaultLanguageId` (see above). For example duplicate `localization_en.json` and rename it to `localization_de.json` for German with the language ID `de`.

After that, you can start changing all values within that new localization file to match that language.

NOTE: The key `languageId` at the very top of the localization data file has to be that languages ID! This will be checked upon language initialization (e.g. when switching to that language). If it doesn't match, the localization data of that language won't be loaded, but no error should occur during runtime.

## Structure of the `languages.json` file

Every language needs to have the following keys defined:
- **id** | The unique numerical ID for the table entry.
- **idTitle** | The language ID for that language. **THIS KEY MUST BE UNIQUE BETWEEN ALL LANGUAGES WITHIN THIS FILE!** Also it must be exactly the same language ID you named the localization data file after. For example for English with language ID `en` this key must be `en` and the file called `localization_en.json`.
- **name** | The name of that language. Best would be to keep all the language names in the default language.
- **nativeName** | The name of that language as spelled in that language. This will be displayed in the language selector within the app, which is visible to the user.
- **countryCode** | The proper country code of that language. This determines the flag displayed in the language selector within the app, which is visible to the user.