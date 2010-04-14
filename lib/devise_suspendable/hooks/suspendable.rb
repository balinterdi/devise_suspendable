# Deny user access whenever his account is not active yet.
Warden::Manager.after_set_user do |record, warden, options|
  if record && record.respond_to?(:suspended?) && record.suspended?
    scope = options[:scope]
    warden.logout(scope)

    # If winning strategy was set, this is being called after authenticate and
    # there is no need to force a redirect.
    if warden.winning_strategy
      # TODO: defining inactive_message in the model does not overwrite
      # the one defined in devise/models/activatable.rb
      # maybe it's because this is loaded as a plugin?
      warden.winning_strategy.fail!(record.inactive_message)
    else
      # TODO: defining inactive_message in the model does not overwrite
      # the one defined in devise/models/activatable.rb
      # maybe it's because this is loaded as a plugin?
      throw :warden, :scope => scope, :message => record.inactive_message
    end
  end
end
