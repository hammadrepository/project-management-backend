class DevelopersController < ApplicationController
  before_action :set_developer, only: [:show, :update, :destroy]

  # GET /developers
  def index
    @developers = Developer.all
    render json: @developers.to_json(:include => [:projects])
  end

  # GET /developers/1
  def show
    render json: @developer
  end

  # POST /developers
  def create
    # Check if project_id exists in params
    @project = Project.find(params[:project_id])

    @dev = Developer.create!(developer_params)
    @dev.projects << @project unless @dev.projects.include?(@project)

    render json: @dev, status: :created, location: @dev

  rescue ActiveRecord::RecordNotFound
    record_not_found("Project")
  rescue ActiveRecord::RecordNotUnique
    record_already_exists(developer_params[:first_name] + developer_params[:last_name])
  rescue Exception => ex
    error(ex)
  end

  # PATCH/PUT /developers/1
  def update
    if @developer.update(developer_params)
      render json: @developer
    else
      render json: @developer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /developers/1
  def destroy
    if @developer.projects.count > 1
      if params[:project_id].present?
        @proj = Project.find(params[:project_id])
        @developer.projects.delete(@proj)
        return render json: { "success": "Developer removed from project!" }
      end
      record_cant_be_deleted("Developer")
    else
      @developer.destroy
      success("Developer Removed!")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = Developer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    record_not_found("Developer")
  end

  # Only allow a list of trusted parameters through.
  def developer_params
    params.require(:developer).permit(:first_name, :last_name, :project_id)
  end
end
