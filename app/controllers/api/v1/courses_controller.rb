class Api::V1::CoursesController < ApplicationController
  respond_to :json

  def index
    respond_with(JSON.pretty_generate(
      ActiveModel::ArraySerializer.new(Course.all, each_serializer: CourseSerializer).as_json))
  end

  def show
    @course = CourseRepository.find_by_course(params[:department], params[:number])
    respond_with(JSON.pretty_generate(
      ActiveModel::ArraySerializer.new(@course, each_serializer: CourseSerializer).as_json))
  end
end
