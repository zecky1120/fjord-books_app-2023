# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_relations, class_name: 'MentionReport', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: 'mentioning_report'
  has_many :mentioned_relations, class_name: 'MentionReport', foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: 'mentioned_report'

  has_many :mentioning_reports, through: :mentioning_relations, source: :mentioned_report
  has_many :mentioned_reports, through: :mentioned_relations, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  after_create do
    generate_mentions(scan_report_ids)
  end

  after_update do
    generate_mentions(scan_report_ids)
    remove_report_ids = mentioning_report_ids - scan_report_ids
    destroy_mentions(remove_report_ids)
  end

  def scan_report_ids
    content.scan(%r{http://127.0.0.1:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
  end

  def generate_mentions(scan_report_ids)
    return if scan_report_ids.empty?

    scan_report_ids.each do |scan_report_id|
      mentioning_relations.create(mentioned_report_id: scan_report_id)
    end
  end

  def destroy_mentions(remove_report_ids)
    return if remove_report_ids.empty?

    remove_report_ids.each do |remove_report_id|
      mentioning_relations.find_by(mentioned_report_id: remove_report_id).destroy
    end
  end
end
