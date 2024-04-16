# frozen_string_literal: true

class ReportsController < ApplicationController
  def index
    @reports = Report.order(:id, :created_at)
  end

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @report.user_id = current_user.id
    if @report.save
      redirect_to @report
    else
      render :new
    end
  end

  def show
    @report = Report.find(params[:id])
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to @report
    else
      render :edit
    end
  end

  def destroy
    @report = Report.find(params[:id])
    if @report.destroy
      redirect_to reports_path
    else
      render :show
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :content)
  end
end
