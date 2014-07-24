class Response < ActiveRecord::Base
  validates :answer_choice_id, :responder_id, presence: true
  validate :responder_has_not_already_answered_question
  validate :responder_cannot_be_author

  belongs_to(
    :responder,
    :class_name  => "User",
    :foreign_key => :responder_id,
    :primary_key => :id
  )

  belongs_to(
    :answer_choice,
    :class_name  => "AnswerChoice",
    :foreign_key => :answer_choice_id,
    :primary_key => :id
  )

  has_one :question, :through => :answer_choice , :source => :question

  def sibling_responses
    if self.id.nil?
      self.question.responses
    else
      self.question.responses.where("responses.id != ?", self.id)
    end
  end

  def responder_has_not_already_answered_question
    if sibling_responses.exists?(self.responder_id)
      errors[:responder_id] << "can't create multiple responses to the same question."
    end
  end

  def responder_cannot_be_author
    # poll_author = Poll.select(:author_id)
    #                   .joins(questions: { answer_choices: :responses })
    #                   .where('responses.id = ?', self.id)


    poll_author = self.answer_choice.question.poll.author_id

    if poll_author == self.responder_id
      errors[:responder_id] << "can't be the poll author"
    end
  end

end