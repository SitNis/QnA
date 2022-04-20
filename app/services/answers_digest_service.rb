class AnswersDigestService
  def send_notification_to_subscribers
    User.find_each(batch_size: 500) do |user|
      AnswersDigestMailer.digest(user).deliver_later
    end
  end
end
