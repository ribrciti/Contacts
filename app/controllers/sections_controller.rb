class SectionsController < ApplicationController

  layout = false

  def index
    @sections = Section.sorted
  end

  def show
    @section = find_params
  end

  def new
    @section = Section.new({:name => "default"})
  end

  def create
     @section = Section.new(section_params)
     if @section.save
      flash[:notice] = "Section created successfully"
      redirect_to(:action => 'index')
     else
      render('new')
     end
  end

  def edit
    @section = find_params
  end

  def update
    @section = find_params
    if @section.update_attributes(section_params)
      flash[:notice] = "Section updated successfully"
      redirect_to(:action => 'show', :id => @section.id)
    else
      render('edit')
    end  
  end

  def delete
    @section = find_params
  end

  def destroy
    @section = find_params.destroy
    flash[:notice] = "Successfully deleted Section"  
    redirect_to(:action => 'index')  
  end


  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

  def find_params
    Section.find(params[:id])    # page params id is the number before the ?
  end

end
