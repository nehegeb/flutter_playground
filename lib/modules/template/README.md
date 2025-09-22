# The Template Module

This module can be used as a template and quickstart to set up all new modules and pages in the same style and basic functionality. New functionality can be added to this template module as needed in order to set up future modules with them directly. *HINT: It would be helpful to update this `lib/modules/template/README.md` file to reflect the new functionality as well.*

This `README.md` file explains step-by-step how to implement a new main module, a new sub module or a new page for any module. This is done by assuming a fictitious new feature to discribe the process in more detail, as mentioned in the beginning of each section.
**Follow these steps to make sure everything is being set up properly, before working on the new feature.**

*HINT: If needed, the template module can be made visible within the app. This could be helpful for debugging purposes. To do so change the `isHidden` attribute of the template main and sub modules to `false` within the database.*

**NOTE: It is highly suggested to NOT delete the `lib/modules/template` folder at all!**

## HOW TO SET UP A NEW MAIN MODULE

Let's say, the new main module is called `Statistics Board`.

### 1. Add the new main module to the database

1. Add a new entry to either `lib/app/modules/data/main_modules.json` or your own database...

    - **id** | The unique UUID for the table entry.
    
    - **idTitle** | The readable ID and name for this main module, in `camelCase`.
    
        - **NOTE: This MUST be unique between all main modules within this file.** 

        - Set this to `statisticsBoard`.

    - **isPublic** | A boolean, whether this main module is always visible to anyone.

        - *HINT: Everyone will automatically get the `.access` and `.read` permissions for this module, even if not logged in.*
        
        - *HINT: The 'main' module is public by default and cannot be changed.*

    - **isHidden** | A boolean, whether this main module is always hidden from everyone.

        - *HINT: Not even an app administrator will be able to see and access this module.*

        - *HINT: This can be useful if a new module is in development, but it shouldn't be accessible in the production environment yet. So this can be `true` for prod, but `false` for dev.*
        
        - *HINT: The 'template' module is hidden by default.*

    - **isAdministrative** | A boolean, whether this main module is intended for admins only.

        - *HINT: This also highlights the module in a different color in the Module Bar.*
        
        - *HINT: The 'settings' module is administrative by default.*

2. Just note the new main module's `idTitle`, e.g. `statisticsBoard`. It will be needed throughout this guide.

### 2. Add the basic permissions

1. In the `lib/permissions/data` folder...

    - Duplicate the `permissions_template.dart` file and rename it to `permissions_statistics_board.dart`, in `snake_case`.

2. In the new `lib/permissions/data/permissions_statistics_board.dart` file...

    - Change the name of the file in line 1 to `permissions_statistics_board.dart`.

    - Change the comment in line 4, e.g. `/// Statistics Board [AppMainModule] permissions.`.

    - Replace the `Template` of the class name and class constructor in lines 5 and 6 with `StatisticsBoard`, in `PascalCase`.

    - Delete the whole 'template' permissions block in lines 19 to 29.

    - Afterwards also delete the whole line 8 for the `template` variable.

    - Replace the `TemplatePermissions` of the class name and class constructor in lines 19 and 20 with `StatisticsBoardPermissions`, in `PascalCase`.

    - Afterwards update the class name of the `permissions` variable in line 8, e.g. `const StatisticsBoardPermissions();`.

    - In all lines starting with `final String`, replace the first `template.` with `statisticsBoard.`.

        - *HINT: For example line 10 to `'statisticsBoard.*'` and line 22 to `'statisticsBoard.permissions.access'`.*

    - **NOTE: More permissions can be added here later on, if needed. But these basic permissions must NOT be deleted!**

3. In the `lib/permissions/permissions.dart` file...

    - At the top, import the new file by adding `import '<...>/permissions_statistics_board.dart';`, just like the existing imports.

    - Within the class `Permissions`, add a new line `static const StatisticsBoard statisticsBoard = StatisticsBoard();`, just like the existing definitions.

4. In the `lib/permissions/data/permissions_grouped_by_module.dart` file...

    - Duplicate the whole 'template' main module block.

    - Remove all 'template' sub module permissions within, indicated by the comment `// Template [AppSubModule].`.

    - Update the comment above the new block to `// Statistics Board [AppMainModule].`.

    - Update the first line below the comment from `'template'` to `'statisticsBoard'`.
    
    - Rename every permission within, according to the permissions defined earlier.

        - *HINT: For example rename `Permissions.template.permissions.access` to `Permissions.statisticsBoard.permissions.access`.*

### 3. Add the basic user roles

1. Add four new entries to either `lib/app/roles/data/roles.json` or your own database...

    - Locate all four roles with the `isDefaultRole` set to `true`, `mainModuleIdTitle` set to `"template"` and an empty `subModuleIdTitle`.

        - *HINT: These four default role's `idTitle` are `"viewer"`, `"menber"`, `"moderator"` and `"admin"`.*

        - **NOTE: These four default roles are REQUIRED for every module. Otherwise the app might crash or not work as intended.**

    - Duplicate all four default roles and set their `mainModuleIdTitle` to `"statisticsBoard"`.

    - Within the `permissions` of all four new roles, replace the `template.` with `statisticsBoard.`.

        - *HINT: For example change `template.access` to `statisticsBoard.access`.*

    - Generate new UUIDs for all four new roles.

        - **NOTE: This is important, as every `id` MUST be unique. Otherwise the app will not work as intended.**

    - Make sure, `isDefaultRole` is set to `true` for all four new roles.

        - *HINT: If this is set to `false`, a module administrator can change and delete the role in the permission settings.*

    - Leave the rest as is and do NOT change `idTitle`.

### 4. Add the main module's folder

1. In the `lib/modules/` folder...

    - *HINT: This folder holds all main modules of the app.*

    - Duplicate the whole `template` folder and rename it to `statistics_board`, in `snake_case`.

    - Delete the `/statistics_board/README.md` file. It isn't needed in a proper module.

2. In the new `lib/modules/statistics_board/modules/` folder...

    - *HINT: This folder holds all sub modules of the 'Statistics Board' main module.*

    - Delete the whole `template` folder. No 'template' sub module is needed in a proper module.

    - **NOTE: This leaves the `modules` sub module folder empty for now. More sub modules can be added here later on, if needed.**

3. In the new `lib/modules/statistics_board/pages/` folder...

    - *HINT: This folder holds all pages of the 'Statistics Board' main module.*

    - Delete the whole `template` folder. No 'template' page is needed in a proper module.

### 5. Update the pages

1. In all page .dart files within the `lib/modules/statistics_board/pages/` folder...

    - *HINT: For example `/about/about_page.dart`, `/home/home_page.dart`, etc.*

    - Replace the `Template<PageName>` of the class name and class constructor (one line below) with `StatisticsBoard<PageName>`, in `PascalCase`. For example for `TemplateHomePage` rename it to `StatisticsBoardHomePage`.

        - **NOTE: This class name needs to be unique across the entire app to avoid conflicts!**

    - Change the static string `mainModule` to its `idTitle`, e.g. `statisticsBoard`.

    - If applicable, change the permission check to the `.view` permission of the new module. For example for `Permissions.template.view` change it to `Permissions.statisticsBoard.view`.

### 6. Set up the assets folder, module icon and changelog

1. In the `assets/modules/` folder...

    - Duplicate the `template` folder and rename it to `statistics_board`, in `snake_case`.

2. In the new `assets/modules/statistics_board/images` folder...

    - Rename the `templateIcon.png` file to `statisticsBoardIcon.png`, in `camelCase`.
    
        - *HINT: Module icons must be named like `<moduleIdTitle>Icon.png`, in `camelCase`.*

        - **NOTE: This file can be replaced with a custom module icon, but its name must be formatted as stated above. Otherwise the app will crash when trying to load the icon.**

3. In the `pubspec.yaml` file...

    - At the bottom below `flutter:` `assets:` `# Changelogs` add a new line with `- lib/modules/statistics_board/changelog/`.

    - At the bottom below `flutter:` `assets:` `# Assets` add the needed lines with `- assets/modules/statistics_board/images/`.

    - *HINT: More asset folders can be added here later on, if needed. For example `- assets/modules/statistics_board/downloads/`.*

    - To make the assets folder available within the app, run `flutter pub get` in the terminal.
    
        - **NOTE: This has to be run whenever new asset folders are added to the `pubspec.yaml` file. Otherwise the app will crash when trying to load from there.**

        - *HINT: You do not have to run this when simply adding new files to any asset folder itself.*

### 7. Set up the `appRouter`

1. In the `lib/app/module_bar/module_bar_navigation.dart` file...

    - Duplicate the whole 'imports' block `// Template main module pages imports.` at the top and update the folder structure, e.g. replace `/template/` with `/statistics_board/`.

        - *HINT: For example rename `import '<...>/modules/template/pages/home/home_page.dart';` to `import '<...>/modules/statistics_board/pages/home/home_page.dart';`.*

        - Delete the copied line with the import for `<...>/modules/statistics_board/modules/template/pages/home/home_page.dart`. It doesn't exist and no 'template' sub module is needed in a proper module.

        - Update the comment above the new block to `// Statistics Board main module pages imports.`.

    - Duplicate all 'Template' related cases within the `ModuleBarNavigation` class (the block starting with the comment `// Template module pages.`) and update the names within, e.g. replace `Template<...>` with `StatisticsBoard<...>`.

        - *HINT: For example rename `TemplateHomePage` to `StatisticsBoardHomePage`.*

        - Delete the copied block for the 'Template' sub module pages (starting with the comment `// Template sub module pages.`). It doesn't exist and no 'template' sub module is needed in a proper module.

        - Update the comment above the new block to `// Statistics Board module pages.`.

2. In the `lib/app/app_router/app_router.dart` file...

    - Duplicate the whole template block within the `appRouter` (starting with the comment `// Template module.`).

    - Update the comment above the new block for the new module, e.g. `// Statistics Board module`.

    - The first `GoRoute` below the comment defines the home page route of the new module.

        - `path` defines the URL, in `kebab-case`, e.g. `path: "/statistics-board",`.

        - `child` defines the navigation route as defined earlier, e.g. `StatisticsBoardHomePage`.

        - `mainModule` is the `idTitle` of the main module, e.g. `statisticsBoard`.

        - `subModule` is the `idTitle` of the sub module, if any. The home page has none.

        - `redirect` defines the permission needed to access this page, e.g. `Permissions.statisticsBoard.access`.

        - *HINT: Within `routes` are all pages of that main module. Everything besides the home page goes here.*

    - Within `routes`, the first `GoRoute` defines the about page route of the new module.

        - Leave the `path` as `about`.

            - *HINT: Because this is within `routes`, this path will be added to the URL. So the complete URL will now be `/statistics-board/about`.*

        - Change `child` to `StatisticsBoardAboutPage`.

        - Change `mainModule` to `statisticsBoard`.

        - The about page has no `subModule`.

        - Change the `redirect` permission to `Permissions.statisticsBoard.access`.

            - **NOTE: The about page should always be accessible alongside the home page it belongs to. So both pages should always have the same permission.**

    - Within `routes`, the second `GoRoute` defines the template page route.
    
        - Remove this whole block. It doesn't exist and no 'template' route is needed in a proper module.

    - Within `routes`, the last `GoRoute` defines the permissions page route of the new module.

        - *HINT: The permissions page is intended for module admins only. User roles and permissions for the corresponding main module can be managed here.*

        - Leave the `path` as `permissions`.

            - *HINT: Because this is within `routes`, this path will be added to the URL. So the complete URL will now be `/statistics-board/permissions`.*

        - Change `child` to `PermissionsPage`.

            - **NOTE: The permission page is always the same for every module.**

        - Change `mainModule` to `statisticsBoard`.

        - Leave `subModule` as `permissions`.

        - Change the `redirect` permission to `Permissions.statisticsBoard.permissions.access`.

### 8. Set up the localization data

1. In the `lib/app/localization/data/localization_en.json` file...

    - **NOTE: This assumes, the default app language is set to English. This can be changed, see `lib/app/localization/data/README.md`. If changed, use the corresponding default localization file instead.**

    - Duplicate the whole JSON tree for the `template` node within the `modules` node and rename it to `statisticsBoard`, in `camelCase`.

    - Change the `title` node to `"Statistics Board"`.
  
        - *HINT: This is the name of the new main module, i.a. displayed in the Module Bar.*

    - Within the new `modules.statisticsBoard.modules` node, delete the whole `template` node. No 'template' sub module exists for this new main module.

    - Within the new `modules.statisticsBoard.pages` node, delete the whole `template` node. No 'template' page exists for this new main module.

2. Repeat above step for every other localization file in this folder.

    - *HINT: This is optional. Every other language than English (if defined as the default app language) will default back to English, if nothing is defined there yet.*

### 9. Finally, test within the app

1. Start the app in debug mode to make sure everything works.

    - Make sure, the app loads properly without crashing.

    - Make sure, the new main module is visible within the `ModuleBar`.

        - *HINT: If not, make sure your user is logged in and has at least the `.access` and `.view` permissions for the new module.*

        - *HINT: If not, doublecheck the `isHidden` attribute of the module within the database.*

        - *HINT: If the app crashes, most likely no proper icon could be found for the new main module. Doublecheck step 6 again.*

    - Make sure, the new module's home page loads properly by opening it using the `ModuleBar`.

    - Make sure, the about page loads properly by opening it using the `about` button at the bottom right of the new module's home page.

    - Make sure, the changelog loads properly by expanding the dropdown list in the new module's about page.

    - Make sure, the settings page loads properly for an admin user and data can be modified there.

    - Make sure, the localization works for all languages by changing the language and checking all visible texts.
    
        - *HINT: If a text is all caps and in square brackets like `[NO_LOCALIZATION]`, no localization data for the default app language could be found. Doublecheck step 8 again.*

        - *HINT: If a text is not translated into the selected language, most likely no localization data for that language has been defined yet. It'll automatically fall back to the default app language then. Doublecheck step 8 again.*

    - *HINT: If the app crashes on startup or the new main module doesn't work as intended, double check all above steps again.*

## HOW TO SET UP A NEW SUB MODULE

Let's say, the new sub module for the main module `Statistics Board` is called `Charts`.

### 1. Add the new sub module to the database

1. Add a new entry to either `lib/app/modules/data/sub_modules.json` or your own database...

    - **id** | The unique UUID for the table entry.
    
    - **idTitle** | The readable ID and name for this sub module, in `camelCase`.
    
        - **NOTE: This MUST be unique between all sub modules within this file.** 

        - Set this to `charts`.

    - **mainModuleId** | This sub module's main module's `id`.

        - **NOTE: If this is left empty, this sub module won't show up in the app. If it's incorrect, the app might crash.**

        - Check the `id` of the `statisticsBoard` main module and set it here.

    - **mainModuleIdTitle** | This sub module's main module's `idTitle`.

        - **NOTE: If this is left empty, this sub module won't show up in the app. If it's incorrect, the app might crash.**
        
        - Set this to `statisticsBoard`.

    - **isPublic** | A boolean, whether this sub module is always visible to anyone.

        - *HINT: Everyone will automatically get the `.access` and `.read` permissions for this module, even if not logged in.*

        - *HINT: This won't have an effect if the sub module's main module is hidden.*

    - **isHidden** | A boolean, whether this sub module is always hidden from everyone.

        - *HINT: Not even an app administrator will be able to see and access this module.*

        - *HINT: This can be useful if a new module is in development, but it shouldn't be accessible in the production environment yet. So this can be `true` for prod, but `false` for dev.*
        
        - *HINT: The 'template' module is hidden by default.*

    - **isAdministrative** | A boolean, whether this sub module is intended for admins only.

        - *HINT: This also highlights the module in a different color in the Module Bar.*
        
        - *HINT: The 'permissions' module is administrative by default.*

2. Just note the new sub module's `idTitle`, e.g. `charts`. It will be needed throughout this guide.

### 2. Add the basic permissions

1. In the `lib/permissions/data/permissions_template.dart` file...

    - Copy the whole `TemplateTemplate` class, including it's comment above.

2. In the `lib/permissions/data/permissions_statistics_board.dart` file...

    - Paste the copied class within the `StatisticsBoard` class.

    - Change the comment above the new class, e.g. `/// Charts [AppSubModule] permissions.`.

    - Replace the `TemplateTemplate` of the class name and class constructor with `StatisticsBoardCharts`, in `PascalCase`.

    - Afterwards, at the top of the `StatisticsBoard` class, add the new `charts` variable, e.g. `final charts = const StatisticsBoardCharts();`.

    - Within the new `StatisticsBoardCharts` class, in all lines starting with `final String`, replace the `template.template.` with `statisticsBoard.charts.`.

        - *HINT: For example, change `'template.template.access'` to `'statisticsBoard.charts.access'`.*

    - **NOTE: More permissions can be added here later on, if needed. But these basic permissions must NOT be deleted!**

3. In the `lib/permissions/data/permissions_grouped_by_module.dart` file...

    - Locate the 'template' main module block, indicated by the comment `// Template [AppMainModule].`.

        - Copy the whole 'template' sub module block within, indicated by the comment `// Template [AppSubModule].`.

    - Locate the 'statisticsBoard' main module block, indicated by the comment `// Statistics Board [AppMainModule].`.

        - Paste the copied block within.

        - Update the comment above the new block to `// Charts [AppSubModule].`.
    
        - Rename every pasted permission, according to the permissions defined earlier.

            - *HINT: For example rename `Permissions.template.template.access` to `Permissions.statisticsBoard.charts.access`.*

### 3. Add the basic user roles

1. Add four new entries to either `lib/app/roles/data/roles.json` or your own database...

    - Locate all four roles with the `isDefaultRole` set to `true`, `mainModuleIdTitle` set to `"template"` and `subModuleIdTitle` set to `"template"`.

        - *HINT: These four default role's `idTitle` are `"viewer"`, `"menber"`, `"moderator"` and `"admin"`.*

        - **NOTE: These four default roles are REQUIRED for every module. Otherwise the app might crash or not work as intended.**

    - Duplicate all four default roles and set their `mainModuleIdTitle` to `"statisticsBoard"` and `subModuleIdTitle` to `"charts"`.

    - Within the `permissions` of all four new roles, replace the `template.template.` with `statisticsBoard.charts.`.

        - *HINT: For example change `template.template.access` to `statisticsBoard.charts.access`.*

    - Generate new UUIDs for all four new roles.

        - **NOTE: This is important, as every `id` MUST be unique. Otherwise the app will not work as intended.**

    - Make sure, `isDefaultRole` is set to `true` for all four new roles.

        - *HINT: If this is set to `false`, a module administrator can change and delete the role in the permission settings.*

    - Leave the rest as is and do NOT change `idTitle`.

### 4. Add the sub module's folder

1. In the `lib/modules/template/modules/` folder...

    - Copy the whole `template` folder.

2. In the `lib/modules/statistics_board/modules/` folder...

    - *HINT: This folder holds all sub modules of the 'Statistics Board' main module.*

    - *HINT: If there's no `modules` folder for sub modules, just create it.*

    - Paste the copied folder and rename it to `charts`, in `snake_case`.

3. In the new `lib/modules/statistics_board/modules/charts/pages/` folder...

    - *HINT: This folder holds all pages of the 'Charts' sub module.*

    - Delete the whole `template` folder. No 'template' page is needed in a proper module.

### 5. Update the pages

1. In all page .dart files within the `lib/modules/statistics_board/modules/charts/pages/` folder...

    - *HINT: For example `/home/home_page.dart`, etc.*

    - Replace the `TemplateTemplate<PageName>` of the class name and class constructor (one line below) with `StatisticsBoardCharts<PageName>`, in `PascalCase`. For example for `TemplateTemplateHomePage` rename it to `StatisticsBoardChartsHomePage`.

        - **NOTE: This class name needs to be unique across the entire app to avoid conflicts!**

    - Change the static string `mainModule` to its `idTitle`, e.g. `statisticsBoard`.

    - Change the static string `subModule` to its `idTitle`, e.g. `charts`.

    - If applicable, change the permission check to the `.view` permission of the new module. For example for `Permissions.template.template.view` change it to `Permissions.statisticsBoard.charts.view`.

### 6. Set up the module icon

1. In the `assets/modules/template/images` folder...

    - Copy the `templateIcon.png` file.

2. In the `assets/modules/statistics_board/images` folder...

    - Paste the copied file and rename it to `chartsIcon.png`, in `camelCase`.
    
        - *HINT: Module icons must be named like `<moduleIdTitle>Icon.png`, in `camelCase`.*

        - **NOTE: This file can be replaced with a custom module icon, but its name must be formatted as stated above. Otherwise the app will crash when trying to load the icon.**

### 7. Set up the `appRouter`

1. In the `lib/app/module_bar/module_bar_navigation.dart` file...

    - Within the imports block for the new sub module's main module at the top (indicated by the comment `// Statistics Board main module page imports.`), add a new import for its new home page, e.g. `import: '<...>/modules/statistics_board/modules/charts/pages/home/home_page.dart';`.

    - Within the `ModuleBarNavigation` class and the block for the new sub module's main module (indicated by the comment `// Statistics Board module pages.`), add a new comment for the new sub module, e.g. `// Charts sub module pages.`.

    - Add a new case for the home page directly below, e.g. `case 'StatisticsBoardChartsHomePage: return StatisticsBoardChartsHomePage();`.

2. In the `lib/app/app_router/app_router.dart` file...

    - Locate the 'Template' module block, indicated by the comment `// Template module.`.

        - Within `routes`, copy the whole `GoRoute` starting with `path: "template",`.

    - Locate the 'Statistics Board' module block, indicated by the comment `// Statistics Board module.`.

        - Within `routes`, paste the copied `GoRoute`.

        - Change `path` to `charts`, in `kebab-case`.

            - *HINT: Because this is within `routes` of the main module, this path will be added to the URL. So the complete URL will now be `/statistics-board/charts`.*

        - Change `child` to `StatisticsBoardChartsHomePage`.

        - Change `mainModule` to `statisticsBoard`.

        - Change `subModule` to `charts`.

        - Change the `redirect` permission to `Permissions.statisticsBoard.charts.access`.

### 8. Set up the localization data

1. In the `lib/app/localization/data/localization_en.json` file...

    - **NOTE: This assumes, the default app language is set to English. This can be changed, see `lib/app/localization/data/README.md`. If changed, use the corresponding default localization file instead.**

    - Locate the JSON tree node `modules.template.modules`.

        - Copy the whole `template` node within.

    - Locate the JSON tree node `modules.statisticsBoard.modules` for the new sub module's main module.

        - Paste the copied node within and rename it to `graphs`, in `camelCase`.

        - Change the `title` key within to `"Graphs"`.
    
          - *HINT: This is the name of the new sub module, i.a. displayed in the Module Bar.*

    - Locate the new JSON tree node `modules.statisticsBoard.modules.graphs.pages`.

        - Rename the `template` node to `graphs`.

        - Change the `title` key within to `"Graphs Page"` (or to whatever fits best).
    
            - *HINT: This is the text that is displayed at the top of the page itself.*

2. Repeat above step for every other localization file in this folder.

    - *HINT: This is optional. Every other language than English (if defined as the default app language) will default back to English, if nothing is defined there yet.*

### 9. Finally, test within the app

1. Start the app in debug mode to make sure everything works.

    - Make sure, the app loads properly without crashing.

    - Make sure, the new sub module is visible within the `ModuleBar`, by expanding the corresponding main module.

        - *HINT: If not, make sure your user is logged in and has at least the `.access` and `.view` permissions for the new module.*

        - *HINT: If not, doublecheck the `isHidden` attribute of the module within the database.*

        - *HINT: If the app crashes, most likely no proper icon could be found for the new sub module (or the template sub module). Doublecheck step 6 again.*

    - Make sure, the new module's home page loads properly by opening it using the `ModuleBar`.

    - Make sure, the localization works for all languages by changing the language and checking all visible texts.
    
        - *HINT: If a text is all caps and in square brackets like `[NO_LOCALIZATION]`, no localization data for the default app language could be found. Doublecheck step 8 again.*

        - *HINT: If a text is not translated into the selected language, most likely no localization data for that language has been defined yet. It'll automatically fall back to the default app language then. Doublecheck step 8 again.*

    - *HINT: If the app crashes on startup or the new sub module doesn't work as intended, double check all above steps again.*

## HOW TO SET UP A NEW PAGE FOR A MODULE

Let's say, the new page for the sub module `Charts` is called `Line Graph`.

### 1. Add the page's folder

1. In the `lib/modules/template/modules/template/pages/` folder...

    - Copy the whole `template` folder within.

2. In the `lib/modules/statistics_board/modules/charts/pages/` folder...

    - Paste the copied `template` folder and rename it to `line_graph`, in `snake_case`.

    - Also rename the `template_page.dart` file within the new `line_graph` folder to `line_graph_page.dart`, in `snake_case`.

- **NOTE: The steps to set up a new page for a main module, a sub module or the app itself are the same, just the paths are different, of course.**

    - App pages path: `lib/modules/main/pages/`

        - The page template is located at `lib/modules/template/pages/`.

    - Main module pages path: `lib/modules/<main_module>/pages/`

        - The page template is located at `lib/modules/template/pages/`.

    - Sub module pages path: `lib/modules/<main_module>/modules/<sub_module>/pages/`

        - The page template is located at `lib/modules/template/modules/template/pages/`.

### 2. Update the page

1. In the `lib/modules/statistics_board/modules/charts/pages/line_graph/line_graph_page.dart` file...

    - Change the file name in the very first name to `line_graph_page.dart`.

    - Replace the `TemplateTemplateTemplatePage` of the class name and class constructor (one line below) with `StatisticsBoardChartsLineGraphPage`, in `PascalCase`.

        - **NOTE: This class name needs to be unique across the entire app to avoid conflicts!**

    - Change the static string `mainModule` to its `idTitle`, e.g. `'statisticsBoard'`.

    - Change the static string `subModule` to its `idTitle`, e.g. `'charts'`.

    - Change the permission check to the `.view` permission of the page, e.g. `Permissions.statisticsBoard.charts.view`.

        - *HINT: This is the `.view` permission of the whole 'charts' sub module. This can be changed later on, if this 'charts' page gets its own permission.*

    - Change the `.template.` within the text localization to `.lineGraph.`, e.g. `'modules.$mainModule.modules.$subModule.pages.lineGraph.title'`.

    - *HINT: For more information see the setup comment block at the top of the copied `template_page.dart` file. This comment block can be deleted afterwards.*

- **NOTE: The classes of pages are put together by adding the module names in front. This is necessary for the `appRouter` to find the correct page to display, as they need to be unique.**

    - App page class name: `<PageName>Page`, e.g. `LineGraphPage`.

    - Main module page class name: `<MainModule><PageName>Page`, e.g. `StatisticsBoardLineGraphPage`.

    - Sub module page class name: `<MainModule><SubModule><PageName>Page`, e.g. `StatisticsBoardChartsLineGraphPage`.

### 3. Set up the `appRouter`

1. In the `lib/app/module_bar/module_bar_navigation.dart` file...

    - Within the imports block for the new page's main module at the top (indicated by the comment `// Statistics Board main module page imports.`), add a new import for the new page, e.g. `import: '<...>/modules/statistics_board/modules/charts/pages/line_graph/line_graph_page.dart';`.

    - Within the `ModuleBarNavigation` class, locate the block for the new page's main module (indicated by the comment `// Statistics Board module pages.`).

    - Within the this block, locate the block for the new page's sub module (indicated by the comment `// Graphs sub module pages`).

    - Within this block, add a new case for the new page, e.g. `case 'StatisticsBoardChartsLineGraphPage: return StatisticsBoardChartsLineGraphPage();`.

2. In the `lib/app/app_router/app_router.dart` file...

    - Locate the 'Template' module block, indicated by the comment `// Template module.`.

        - Within `routes`, copy the whole `GoRoute` starting with `path: "template"`.

    - Locate the 'Statistics Board' module block, indicated by the comment `// Statistics Board module.`.

        - Within `routes`, paste the copied `GoRoute`.

        - Change `path` to `line-graph`, in `kebab-case`.

            - *HINT: Because this is within `routes` of the main module, this path will be added to the URL. So the complete URL will now be `/statistics-board/line-graph`.*

        - Change `child` to `StatisticsBoardChartsLineGraphPage`.

        - Change `mainModule` to `statisticsBoard`.

        - Change `subModule` to `charts`.

        - Change the `redirect` permission to `Permissions.statisticsBoard.charts.access`.

    - *HINT: A page can be nested beneath its sub module URL like `/statistics-board/charts/line-graph`. For this, add a `routes` list within the sub module's `GoRoute` (e.g. the one starting with `path: "statistics-board"`) and paste the copied `GoRoute` there. The rest is the same as described above.*

### 4. Set up the localization data

1. In the `lib/app/localization/data/localization_en.json` file...

    - **NOTE: This assumes, the default app language is set to English. This can be changed, see `lib/app/localization/data/README.md`. If changed, use the corresponding default localization file instead.**

    - Locate the JSON tree node `modules.template.modules.template.pages`.

        - Copy the whole `template` node within.

    - Locate the JSON tree node `modules.statisticsBoard.modules.graphs.pages` for the new page's sub module.

        - Paste the copied node within and rename it to `lineChart`, in `camelCase`.

        - Change the `title` key within to `"Line Chart Page"` (or to whatever fits best).
    
            - *HINT: This is the text that is displayed at the top of the page itself.*

2. Repeat above step for every other localization file in this folder.

    - *HINT: This is optional. Every other language than English (if defined as the default app language) will default back to English, if nothing is defined there yet.*

- **NOTE: The steps to set up the localization data for a main module, a sub module or the app itself are the same, just the location within the JSON file are different, of course.**

    - App page node: `modules.main.pages`

    - Main module page node: `modules.<mainModule>.pages`

    - Sub module page node: `modules.<mainModule>.modules.<subModule>.pages`

### 5. Add a way to access the new page

1. Somewhere in the 'charts' sub module, add a way to access this new 'Line Graph' page.

    - *HINT: The easiest way is to simply add a button to the home page of the sub module (i.e. within the `lib/modules/statistics_board/modules/charts/pages/home/home_page.dart` file) and let it perform `appRouter.go('/statistics-board/line-graph')`. The 'appRouter' file has to be imported for this to work, of course.*

### 6. Finally, test within the app

1. Start the app in debug mode to make sure everything works.

    - Make sure, the app loads properly without crashing.

    - Make sure, the new page loads properly.

        - *HINT: If not, make sure your user is logged in and has at least the `.access` and `.view` permissions for the new page, if custom permissions were defined.*

    - Make sure, the localization works for all languages by changing the language and checking all visible texts.

    - *HINT: If the app crashes on startup or the new page doesn't work as intended, double check all above steps again.*
