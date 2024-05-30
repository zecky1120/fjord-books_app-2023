# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_relations, class_name: "MentionReport", foreign_key: :mentioning_report_id, dependent: :destroy
  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report

  has_many :mentioned_relations, class_name: "MentionReport", foreign_key: :mentioned_report_id, dependent: :destroy
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def set_mentioning_report_ids
    @mentioning_report_ids = find_report_ids(@report.content)
  end

  def find_report_ids(content)
    content.scan(%r{http://127.0.0.1:3000/reports/([+-]?\d+)}).flatten.map(&:to_i).uniq
  end

end
