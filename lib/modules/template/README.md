# How to set up a new module

1. Duplicate the "template" folder in the lib/modules folder and rename it in snake case.
2. In the pages folder of the new module, adjust the "module" variable near the top for all pages.
3. In the same pages, replace the "Template" of the widget names at the top with the new name.
3. ...
0. In at least the file for the english language within localization\src, duplicate the whole JSON tree for the template within the "modules" node and rename it in camel case.
0. In the assets/modules folder, create a new folder for the new module.
0. In the pubspec.yaml under "Flutter: Assets: # Changelogs", add a new line for this new module.
0. In the pubspec.yaml under "Flutter: Assets: # Assets", add the needed lines for this new module.
0. Delete this README.md file from the new module folder.
