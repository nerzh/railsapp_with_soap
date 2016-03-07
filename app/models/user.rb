class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable, :rememberable,
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable
end