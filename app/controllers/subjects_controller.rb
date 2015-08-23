class SubjectsController < ApplicationController

  layout "admin" #layout admin means go to layouts and use views/layouts/admin.html.erb

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = find_params
  end

  def new
    @subject = Subject.new({:name => "Default"})  # @subject not necessary, but include as best practise
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      flash[:notice] = "Subject created successfully"     ## add flash hash
      redirect_to(:action => 'index')
    else
      render('new')
       @subject_count = Subject.count + 1
    end
  end

  def edit
    @subject = find_params
    @subject_count = Subject.count
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @subject = find_params
    if @subject.update_attributes(subject_params) # this line returns true or false
      flash[:notice] = "Subject updated successfully"     ## add flash hash
      redirect_to(:action => 'show', :id => @subject.id)
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
     @subject = find_params
  end

  def destroy
    @subject = find_params.destroy
    flash[:notice] = "Subject destroyed successfully"     ## add flash hash
    redirect_to(:action => 'index')
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def find_params
    Subject.find(params[:id])
  end
end
