module FormsHelper
  def fill_form(form_name, opts = {})
    values = {}
    case form_name
      when /feature/
        values = {"title" => Sham.feature, "in_order" => 'to create the best app', "as_a" => 'user', "i_want" => 'the best project ever'}
      when /project/
        values = {"title" => Sham.title, "aim" => 'An aim', "description" => 'A description', "location" => "#{RAILS_ROOT}"}
      when /story/
        values = {"scenario" => Sham.scenario }
      when /step/
        values = {"title" => Sham.step }
      when /resource/
        values = {"name" => "baphled", "project" => "50164"}
      else
        raise "Can't find the form #{form_name}.\n" +
          "Now, go and add a mapping in #{__FILE__}"
    end

    parmas = values.merge(opts)
    parmas.each { |param, value| When %{we fill in the #{form_name} #{param} with '#{value}'} }
  end

  def fill_in_form_with_duplicate_data form_name
    model = form_name.capitalize.constantize.make
    opts = model.attributes
    unsubmitables = ['created_at', 'updated_at', 'path']
    model.attributes.each { |key, attribute| unsubmitables << key if not key.match(/id$/).nil? }
    unsubmitables.each { |param| opts.delete param }
    fill_form form_name.singularize, opts
  end
end
