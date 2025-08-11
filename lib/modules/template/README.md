# The Template Module

This module can be used as a template and quickstart to set up all new modules in the same style and basic functionality.

## How to set up a new main module

Let's say, the new main module is called `Statistics Board`.

1. In the `lib/modules/` folder...
  - Duplicate the `template` folder and rename it to `statistics_board`, in `snake_case`.
  - Delete the `/statistics_board/README.md` file.
2. In all page .dart files within the `lib/modules/statistics_board/pages/` folder...
  - Replace the `Template<PageName>` of the class name with `StatisticsBoard<PageName>`, in `PascalCase`. For example for `TemplateHomePage` rename it to `StatisticsBoardHomePage`.
  - Change the `module` variable near the top to `statisticsBoard`, in `camelCase`.
3. In the `assets/modules/` folder...
  - Duplicate the `template` folder and rename it to `statistics_board`, in `snake_case`.
4. In the `pubspec.yaml` file...
  - At the bottom under `flutter:` `assets:` `# Changelogs` add a new line with `- lib/modules/statistics_board/changelog/`.
  - At the bottom under `flutter:` `assets:` `# Assets` add the needed lines with `- assets/modules/statistics_board/images/`.
  - Further asset folders have to be added here as well later on.
5. In the `lib/app/module_bar/widgets/module_bar_navigation.dart` file...
  - Duplicate the whole imports-block `// Template module imports.` at the top and update the folder structure, e.g. replace `/template/` with `/statistics_board/`.
  - Duplicate all template related cases within the `ModuleBarNavigation` class and update the names, e.g. replace `Template<...>` with `StatisticsBoard<...>`.
6. TODO: app router...
7. In at least `lib/app/localization/data/localization_english.json`...
  - Duplicate the whole JSON tree for the `template` node within the `modules` node and rename it to `statisticsBoard`, in `camelCase`.
  - Change the `title` node to `Statistics Board`, which will be displayed in the app.
  - Any other language will default to English if nothing is defined there yet.
8. Run the `flutter pub get` command in the terminal.
9. Start the app to make sure everything works.

## How to set up a new sub module

Let's say, the new sub module for the main module `Statistics Board` is called `Charts`.

1. In the `lib/modules/statistics_board/modules/` folder...
  - Duplicate the `template` folder and rename it to `charts`, in `snake_case`.
2. In all page .dart files within the `lib/modules/statistics_board/modules/charts/pages/` folder...
  - Replace the `TemplateTemplate<PageName>` of the class name with `StatisticsBoardCharts<PageName>`, in `PascalCase`. For example for `TemplateTemplateHomePage` rename it to `StatisticsBoardChartsHomePage`.
  - Change the `module` variable near the top to `charts`, in `camelCase`.
TODO: ...
0. In the `lib/app/module_bar/widgets/module_bar_navigation.dart` file...
  - Add a new import for the new page at the top.
  - Add a new case for the new page within the `ModuleBarNavigation` class.
9. Start the app to make sure everything works.

## How to set up a new page for a module

Let's say, the new page for the sub module `Charts` is called `Line Graph`.

1. The page template is located at `lib/modules/template/pages/`. Copy the whole `template` folder within.
2. In the `lib/modules/statistics_board/modules/charts/pages/` folder...
  - Paste the copied `template` folder and rename it to `line_graph`, in `snake_case`.
  - Also rename the `template.dart` file within the new `line_graph` folder to `line_graph.dart`, in `snake_case`.
TODO: ...
0. In the `lib/app/module_bar/widgets/module_bar_navigation.dart` file...
  - Add a new import for the new page at the top.
  - Add a new case for the new page within the `ModuleBarNavigation` class.
9. Start the app to make sure everything works.

Note: The steps to set up a new page for a main module or the framework itself are the same, just the paths are different of course.
- Framework path:   `lib/pages/`
- Main module path: `lib/modules/<main_module>/pages/`
- Sub module path:  `lib/modules/<main_module>/modules/<sub_module>/pages/`

Note: The classes of pages are put together by adding the module names in front. This is necessary for the `appRouter` to find the correct page to display, as they need to be unique.
- Framework page class name:   `<PageName>Page`
- Main module page class name: `<MainModule><PageName>Page`
- Sub module page class name:  `<MainModule><SubModule><PageName>Page`
- e.g. `LineGraphPage`; `StatisticsBoardLineGraphPage`; `StatisticsBoardChartsLineGraphPage`
