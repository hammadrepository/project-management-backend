class ApplicationController < ActionController::API

  def record_not_found(name = "Record")
    error = {
      "status" => 404,
      "title" =>  "Not found",
      "detail" => name + " not found!"
    }
    render json: { "errors": [ error ] }, status: 404
  end

  def record_already_exists(param)
    error = {
      "status" => 409,
      "title" =>  "Record already exists!",
      "detail" => param + " already exists!"
    }
    render json: { "errors": [ error ] }, status: 409
  end

  def param_not_allowed(param)
    error = {
      "status" => 404,
      "title" =>  "Param not allowed",
      "detail" => param + " can not be changed!"
    }
    render json: { "errors": [ error ] }, status: 422
  end

  def record_cant_be_deleted(name)
    error = {
      "status" => 409,
      "title" =>  name + " can't be deleted!",
      "detail" => name + " is associated with other projects"
    }
    render json: { "errors": [ error ] }, status: 409
  end


  def success(msg = 'Success')
    error = {
      "status" => 200,
      "title" =>  "Success",
      "detail" => msg
    }
    render json: { "data": [ error ] }, status: 200
  end

  def error(ex)
    error = {
      "status" => 400,
      "title" =>  "Error",
      "detail" => ex
    }
    render json: { "errors": [ error ] }, status: 400
  end
end
