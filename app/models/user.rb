class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :authored_polls,
    :class_name  => "Poll",
    :foreign_key => :author_id,
    :primary_key => :id
  )

  has_many(
    :responses,
    :class_name  => "Response",
    :foreign_key => :responder_id,
    :primary_key => :id
  )

  def completed_polls_sql
    query = Poll.find_by_sql([<<-SQL, self.id])
      SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN (
        SELECT
          responses.*
        FROM
          responses
        WHERE
          responses.responder_id = ?
        ) AS user_responses ON answer_choices.id = user_responses.answer_choice_id
      GROUP BY
        polls.id
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(user_responses.id)
    SQL

  end

  def completed_polls_ar
    Poll.select('polls.*')
      .joins(:questions => :answer_choices)
      .joins("LEFT OUTER JOIN (#{self.responses_subquery.to_sql}) AS responses_subquery ON answer_choices.id = responses_subquery.answer_choice_id")
      .group('polls.id')
      .having('COUNT(DISTINCT questions.id) = COUNT(responses_subquery.id)')
  end

  def responses_subquery
    Response.where('responses.responder_id = ?', self.id)
  end

end





