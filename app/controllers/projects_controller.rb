class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /projects
  def index
    @projects = Project.all
    render json: @projects.to_json(:include => [:developers, :technologies])
  end

  # GET /projects/1
  def show
    render json: @project
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      render json: @project, status: :created, location: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params.except(:start_date))
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end

  end

  # DELETE /projects/1
  def destroy
    # Delete only developers with projects count 1
    @project.developers.each do |developer, index|
      developer = Developer.find(developer.id)
      if developer
        puts developer.projects.count == 1 ? developer.destroy : @project.developers.delete(developer)
      end
    end
    # Finally delete the project
    @project.destroy
    success
  rescue => e
    logger.error "projects#destroy => e #{e.class.name} : #{e.message}"
    error(e)
  end

  # Add developer to existing project
  def addDeveloper()
    developers = Developer.where(id: params[:developers_id])
    @project = Project.find(params[:project_id])
    @project.developers << developers
    render json: @project.to_json(:include => [:developers])

  rescue Exception => ex
    error(ex)
  end

  # Add technology to existing project
  def addTechnology()
    technology = Technology.where(id: params[:technologies_id])
    @project = Project.find(params[:project_id])
    @project.technologies << technology
    render json: @project.to_json(:include => [:technologies])
  rescue Exception => ex
    error(ex)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    return record_not_found
  end

  # Only allow a list of trusted parameters through.
  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date)
  end
end
