# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.order(id: :desc).page(params[:page]).per(10)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user = current_user
    if @report.save
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @report = Report.find(params[:id])
    @comment = Comment.new
    @comments = @report.comments
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      redirect_to reports_path, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
    else
      render :show
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
