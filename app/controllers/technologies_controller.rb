class TechnologiesController < ApplicationController
  before_action :set_technology, only: [:show, :update, :destroy]

  # GET /technologies
  def index
    @technologies = Technology.all
    render json: @technologies
  end

  # GET /technologies/1
  def show
    render json: @technology
  end

  # POST /technologies
  def create

      @tech = Technology.create!(technology_params)
      if (params.has_key?(:project_id))
        if (@proj = Project.find(params[:project_id]))
          @tech.projects << @proj unless @tech.projects.include?(@proj)
        end
      end
      render json: @tech.to_json(:include => :projects)

  rescue ActiveRecord::RecordNotFound
    return record_not_found("Project")
  rescue Exception => ex
    error(ex)
  end

  # PATCH/PUT /technologies/1
  def update
    if @technology.update(technology_params)
      render json: @technology
    else
      render json: @technology.errors, status: :unprocessable_entity
    end
  end

  # DELETE /technologies/1
  def destroy
    if @technology.projects.count == 0
      @technology.destroy
      success("Technology deleted!")
      else
        record_cant_be_deleted("Technology")
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_technology
    @technology = Technology.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def technology_params
    params.require(:technology).permit(:name)
  end
end
