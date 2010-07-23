module AssociationsHelper

  def build_associations_by_amount amount, model, association
    amount = amount.to_i
    amount.times { eval("@#{model}.#{association.pluralize}") << association.capitalize.singularize.constantize.make } unless association.empty?
  end

  def build_model_associations_more_than amount, model, association
    number = amount.to_i + 1
    current_model = eval("@#{model}")
    number.times { current_model.send(association.pluralize.to_sym) << association.singularize.capitalize.constantize.make }
  end

  def build_model_by_amount amount, model
    models = []
    amount.times { models << model.capitalize.singularize.constantize.make }
    model.capitalize.singularize.constantize.stub!(:all).and_return models
  end
end