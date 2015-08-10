class Answer < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  belongs_to :survey
  belongs_to :choice
  belongs_to :question
end
