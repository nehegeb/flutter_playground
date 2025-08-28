// permissions_template.dart
//

/// Template [AppMainModule] permissions.
class Template {
  const Template();

  final template = const TemplateTemplate();
  final permissions = const TemplatePermissions();

  final String access = 'template.access';
  final String view = 'template.view';
  final String edit = 'template.edit';
  final String delete = 'template.delete';
  final String restore = 'template.restore';
}

/// Template [AppSubModule] permissions.
class TemplateTemplate {
  const TemplateTemplate();

  final String access = 'template.template.access';
  final String view = 'template.template.view';
  final String edit = 'template.template.edit';
  final String delete = 'template.template.delete';
  final String restore = 'template.template.restore';
}

/// Permissions [AppSubModule] permissions.
class TemplatePermissions {
  const TemplatePermissions();

  final String access = 'template.permissions.access';
  final String view = 'template.permissions.view';
  final String edit = 'template.permissions.edit';
  final String delete = 'template.permissions.delete';
  final String restore = 'template.permissions.restore';
}
