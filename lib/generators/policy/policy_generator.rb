class PolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_policy
    template_file = File.join('app/policies', '', "#{file_name}_policy.rb" )
    template 'policy.rb', template_file
  end

  def create_policy_spec
    template_file = File.join('spec/policies', '', "#{file_name}_policy_spec.rb" )
    template 'policy_spec.rb', template_file
  end
end
