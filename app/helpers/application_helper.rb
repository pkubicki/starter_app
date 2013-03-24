module ApplicationHelper
  def flash_messages
    if flash.keys.size > 0
      raw(
        flash.map do |type, message| 
          content_tag(:div, message, class: "alert #{alert_class(type)}")
        end.join
      )
    end
  end

  def alert_class(type)
    "alert-#{{ alert: 'error', notice: 'success' }.fetch(type, type.to_s)}"
  end

  def form_errors_on_base(object)
    object = object.object if object.respond_to?(:object)
    if object.errors[:base].any?
      content_tag(:div, class: "alert alert-block alert-error") do
        content_tag(:ul) do
          raw(object.errors[:base].map {|msg| content_tag(:li, msg)}.join)
        end
      end
    end
  end

  def control_group(object, attribute, html_class = nil)
    html_class = ['control-group', html_class].join(' ')
    html_class += object.errors[attribute].blank? ? '' : ' error'
    content_tag(:div, class: html_class) do
      yield
    end
  end

  def currency(num)
    number_to_currency(num, precision: 2, delimiter: ' ', separator: ',', unit: '').strip
  end
  
  def link_to_with_icon(*args)
    name = args.first
    icon = args.second
    url = args.third
    html_options = args.fourth || {}
    link_to(content_tag(:i, '', class: icon) + ' ' + name, url, html_options)
  end

  def button_with_icon(*args)
    name = args.first
    icon = args.second
    html_options = args.third
    content_tag(:button, content_tag(:i, '', class: icon) + ' ' + name, html_options)
  end

  def nav_link_to(*args)
    name = args.first
    url = args.second
    url_options = Rails.application.routes.recognize_path(url) || {}
    html_options = args.third || {}
    html_class = request.fullpath.split('?').first == url.split('?').first ? 'active' : ''
    if allowed_to?(url_options[:action] ? url_options[:action] : 'index', url_options[:controller])
      content_tag(:li, link_to(name, url, html_options), class: html_class)
    end
  end

  def nav_link_to_with_icon(*args)
    name = args.first
    icon = args.second
    url = args.third
    url_options = Rails.application.routes.recognize_path(url)
    html_options = args.fourth || {}
    html_class = request.fullpath.split('?').first == url.split('?').first ? 'active' : ''
    if allowed_to?(url_options[:action] ? url_options[:action] : 'index', url_options[:controller])
      content_tag(:li, link_to_with_icon(name, icon, url, html_options), class: html_class)
    end
  end

  def nav_dropdown(name, &block)
    content_tag(:li, class: 'dropdown') do
      link_to(
        name.html_safe + content_tag(:b, '', class: 'caret'),
        '#',
        {:class => 'dropdown-toggle', :'data-toggle' => 'dropdown'}
      ) + 
      content_tag(:ul, capture(&block), class: "dropdown-menu")
    end
  end
 
  # returns localized datetime or nil
  def ldt(datetime)
    datetime ? l(datetime) : nil
  end 
  
  # returns localized ransack query param for given key
  def ldtqp(key)
    params[:q].try{|q| q[key].present? ? l(q[key].to_datetime) : nil }
  end
end
