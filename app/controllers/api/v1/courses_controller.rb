class Api::V1::CoursesController < ApplicationController
  respond_to :json

  def index
    courses = CourseRepository.where_course(course_params_index)
    courses = courses.page(params[:page]).per_page(40)
    respond_with(JSON.pretty_generate(
      ::ArraySerializer.new(courses, each_serializer: CourseSerializer).as_json))
  end

  def show
    courses = CourseRepository.where_course(course_params_show)
    courses = courses.page(params[:page]).per_page(40)

    respond_with(JSON.pretty_generate(
      ::ArraySerializer.new(courses, each_serializer: CourseSerializer).as_json))
  end

  private
  def course_params_index
    params.permit(:term)
  end
  def course_params_show
    params.permit(:department, :number, :section, :term)
  end
end
