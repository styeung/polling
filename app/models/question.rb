class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  belongs_to(
    :poll,
    :class_name  => "Poll",
    :foreign_key => :poll_id,
    :primary_key => :id
  )

  has_many(
    :answer_choices,
    :class_name  => "AnswerChoice",
    :foreign_key => :question_id,
    :primary_key => :id
  )

  has_many :responses, :through => :answer_choices, :source => :responses

  def results_n_plus_one
    self.answer_choices.each_with_object({}) do |answer_choice, results|
      results[answer_choice.text] = answer_choice.responses.length
    end
  end

  def results_includes
    {}.tap do |results|
      self.answer_choices.includes(:responses).each do |answer_choice|
        results[answer_choice.text] = answer_choice.responses.length
      end
    end
  end

  def results_sql
    query = AnswerChoice.find_by_sql([<<-SQL, self.id])
      SELECT
        answer_choices.*, COUNT(responses.id) AS response_count
      FROM
        answer_choices
      LEFT OUTER JOIN
        responses ON answer_choices.id = responses.answer_choice_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    query.each_with_object({}) do |answer_choice, results|
      results[answer_choice.text] = answer_choice.response_count
    end
  end

  def results_active_record
    query = self.answer_choices
      .select("answer_choices.*, COUNT(responses.id) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id")
      .where("answer_choices.question_id = ?", self.id)
      .group("answer_choices.id")

      query.each_with_object({}) do |answer_choice, results|
        results[answer_choice.text] = answer_choice.response_count
      end
  end

end














