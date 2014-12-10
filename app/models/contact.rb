class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "Email is invalid")
    end
  end
end

class Contact < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :state, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :email, email: true
  validates :notes, length: { maximum: 500, message: "Notes are too long (max 500 characters)"}
  validates :state, inclusion: { in: %w(MA CA FL NY), message: "State must be real" }

  def full_name
    [first_name, last_name].join(' ')
  end

  def location
    [city, state].join(', ')
  end

  def self.alphabetically
    order('LOWER(first_name) ASC')
  end
end
