ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  unless html_tag =~ /<label/
    %|#{html_tag} <p class="help-block mt0">#{[instance.error_message].join(', ')}</p>|.html_safe
  else
    html_tag
  end
end
