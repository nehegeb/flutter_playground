# Roles and Permissions

For every module, page or feature there can be multiple permissions. These permissions can be assigned to roles and these roles can then be assigned to users. This way each user can be granted different privileges in a straight forward and easy way.

## Roles

Roles can be created and modified and then assigned to different users by users with an appropriate permission. Some default roles are marked as `isDefaultRole`, which cannot be changed nor deleted - they are provided by the app itself for general purpose, but are mostly optional.

Multiple permissions (see below) can be assigned to each role. Permissions are defined by the app itself and correspond to different modules, pages or features within.

## Permissions

Structure: `<main_module>.<sub_module>.<more_pages_or_features>.<action>`

*Permissions are provided to roles as a list of several strings, one per permission. Each individual permission is written in segments, each segment separated by a dot and each segment is written in `snake_case`.*

For example `"template.access,template.view"` gives the user the rights to access and view the 'Template' main module.

- A user does not need any permissions to access the main app pages. They are always accessible to everyone.
- Modules marked as `isPublic` are always accessible to everyone. This automatically grants `.access` and `.view`, but nothing more.
- Modules marked as `isHidden` are always accessible to no one, not even to a `*` permission.
- A simple `*` permission gives the user full rights to the whole app and everything within (except hidden modules)!

Everything before the `.<action>` is called `context` in the following descriptions. Here is a list of actions:

### .access
Grants access to the specified `context`. This makes a main or sub module visible in the module bar for the user.
NOTE: This does not give the user view permission for the `context`!

### .view
Grants view rights for the specified `context`. Without this the user cannot see much or anything at all there.
NOTE: This does not give the user access to a module or `context`!

### .edit
Grants edit rights for the specified `context`. This allows to modify elements there, but not delete them.
NOTE: This does not give the user access to a module or `context`!

### .delete
Grants delete rights for the specified `context`. This allows to delete elements there, but not restore them (if applicable).
NOTE: This does not give the user access to a module or `context`!

### .restore
Grants restore rights fo the specified `context`. This allows to restore deleted elements there (if applicable), but not delete them.
NOTE: This does not give the user access to a module or `context`!

### .*
Grants full rights for the specified `context`. This basically gives the user admin-privileges there!

### .click OR .export OR .filter OR ...
There may be more possible actions that are specific to certain features. For example `statistics_board.charts.line_graph_page.export_as_pdf`.