class Api::V1::CoursesController < ApplicationController
  respond_to :json

  def index
    courses = Course.page(params[:page]).per_page(40)
    respond_with(JSON.pretty_generate(
      ::CourseArraySerializer.new(courses, each_serializer: CourseSerializer).as_json))
  end

  def show
    course = CourseRepository.find_by_course(params[:department], params[:number])
    course = course.page(params[:page]).per_page(40)

    respond_with(JSON.pretty_generate(
      ::CourseArraySerializer.new(course, each_serializer: CourseSerializer).as_json))
  end
end
