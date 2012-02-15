Acl9::config.merge!({
    :default_role_class_name => 'Role',
    :default_subject_class_name => 'Registration',
    :default_subject_method => :current_registration
  })