class NotesController < ApplicationController
  before_action :set_params, only: %i[ show edit update destroy]

  def index
    @notes = current_user.notes
    #@notes = Note.all.where(user_id: current_user)
  end
  def task_list
    @note_task_lists = current_user.notes.task
  end
  def report_list
    @note_report_lists = current_user.notes.report
  end

  def personal_list
    @note_personal_lists = current_user.notes.personal
  end


  def show
    
  end

  def new
  	@note = Note.new
  end

  def edit
    
  end

  def create
     @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.category_id = params[:category_id]
    @note.selector = params[:selector]
    # raise @note.inspect

    respond_to do |format|
      if @note.save
        format.html { redirect_to @note, notice: "Notes was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
        @note.category_id = params[:category_id]
        @note.selector = params[:selector]
      if @note.update(note_params)
    #raise @note.selector.inspect
        format.html { redirect_to @note, notice: "Notes was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Notes was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
  def set_params
     @note = Note.find(params[:id])
  end
  def note_params
  	params.require(:note).permit(:name, :description, :user_id, :selector, :category_id)
  end
end



