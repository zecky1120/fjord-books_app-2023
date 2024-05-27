# frozen_string_literal: true

class MentionReport < ApplicationRecord
  belongs_to :mentioning_report, class_name: "Report"
  belongs_to :mentioned_report, class_name: "Report"

  validates :mentioning_report, :mentioned_report, uniqueness: true
end
