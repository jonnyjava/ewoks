class GarageRegistration
  include ActiveModel::Model
  attr_accessor :garage, :user, :garage_name

  def self.garage_attributes
    Garage.column_names
  end

  def self.user_attributes
    User.column_names.push('password')
  end

  garage_attributes.each do |attr|
    delegate attr.to_sym, "#{attr}=".to_sym, to: :garage
  end

  user_attributes.each do |attr|
    delegate attr.to_sym, "#{attr}=".to_sym, to: :user
  end

  delegate :id, :persisted?, to: :garage

  validate :validate_children

  def assign_attributes(params)
    garage_attributes = params.slice(*self.class.garage_attributes)
    garage.assign_attributes(garage_attributes)
    user_attributes = params.slice(*self.class.user_attributes)
    user.assign_attributes(user_attributes)

    setup_associations
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        user.save!
        garage.save!
      end
    end
  end

  def garage
    @garage ||= Garage.new
  end

  def user
    @user ||= User.new
  end

  private

  def setup_associations
    garage.name = garage_name
    garage.owner_id = user.id
    garage.country = user.country
    garage.email = user.email
    garage.phone = user.phone
  end

  def validate_children
    setup_associations
    promote_errors(garage) if garage.invalid?
    promote_errors(user) if user.invalid?
  end

  def promote_errors(object)
    child_errors = object.errors
    class_name = object.class.name
    child_errors.each do |attribute, message|
      errors.add("#{class_name.downcase}_#{attribute}", message)
    end
  end
end
