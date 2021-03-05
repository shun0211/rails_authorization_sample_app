class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :ldap_authenticatable

  after_create :assign_admin_role
  after_create :assign_default_role

  def assign_admin_role
    self.add_role(:guest) if self.roles.blank?
  end

  def assign_default_role
    self.add_role(:admin) if self.name == 'admin'
  end
end
