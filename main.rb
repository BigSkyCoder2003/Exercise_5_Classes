# Exercise 5

class DiscussionWorkflow

  def initialize(discussion, host, participants)
		@discussion = discussion
		@host = host
		@participants = participants
	end

  # Expects @participants array to be filled with User objects
  def run
    return unless valid?
    run_callbacks(:create) do
      ActiveRecord::Base.transaction do
        discussion.save!
        create_discussion_roles!
        @successful = true
      end
    end
  end

 

  # ...

end

class User
	def initialize(email, password)
		@email = email
		@password = password
	end

	def get_user_email()
		return(@email)
	end

end


class Participants

	def initialize(participants_email_string)
		@participants_email_string = participants_email_string
		@participants = []
		@participants_email_list = []
	end


	def generate_participant_users_from_email_string
    return if @participants_email_string.blank?
    @participants_email_string.split.uniq.map do |email_address|
      @participants <= User.new(email: email_address.downcase, password: Device.friendly_token)
			@participants_email_list <= @participants[email_address].get_user_email()
    end
  end

	def get_participants()
		return (@participants_email_list)
	end

end


discussion = Discussion.new(title: "fake", ...)
host = User.find(42)

participants_email_string = "fake1@example.com\nfake2@example.com\nfake3@example.com"
participants = Participants.new(participants_email_string)


workflow = DiscussionWorkflow.new(discussion, host, participants.get_participants())
workflow.run
