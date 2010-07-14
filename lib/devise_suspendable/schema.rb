Devise::Schema.class_eval do
  # Creates suspended_at and suspension_reason
  def suspendable
    apply_devise_schema :suspended_at,      DateTime,  :null => true, :default => nil
    apply_devise_schema :suspension_reason, String,    :null => true, :default => nil
  end
end