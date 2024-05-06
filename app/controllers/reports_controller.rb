# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit show update destroy]
  before_action :report_owner, only: %i[edit update destroy]

  def index
    @reports = Report.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @report = Report.new
  end

  def create
    @report = current_user.reports.new(report_params)
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @report.comments
  end

  def edit; end

  def update
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @report.destroy
      redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      render :show
    end
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def report_owner
    owner = @report.user
    redirect_to(reports_path) unless owner == current_user
  end
end
