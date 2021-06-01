class NotesController < ApplicationController
  require 'rest-client'
  respond_to :html, :json

  before_action :set_params, only: %i[ show edit update destroy]

  def index
   # respond_with notes.all
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
    #  @user_data = {}
    #  url = "https://jsonplaceholder.typicode.com/posts"
    # response = RestClient.get'https://jsonplaceholder.typicode.com/posts', {accept: :json }
    #  data = response.body
    #  @data = JSON.parse(data)
    #  @user_data = @data
  	@note = Note.new
  end

  def edit
    
  end

  def create
    # raise params.inspect
    @user_data = {}
    url = "https://jsonplaceholder.typicode.com/posts"
    response = RestClient.get'https://jsonplaceholder.typicode.com/posts', {accept: :json }
    data = response.body
    @data = JSON.parse(data)
    @user_data = @data
    selector_data = (params[:note][:title])
    selector_data = selector_data[0]
    @selector_data = selector_data.split(",").map { |s| s.to_i }
    #@selector_data = selector_data.each_char.map(&:to_i)

    #raise @selector_data.inspect
    user_data = []
    @user_data.each do |ud|
      udata = ud['id']
      user_data.push udata
    end
    total_arr = user_data + @selector_data
    total_val = total_arr.select{|item| total_arr.count(item) > 1}.uniq
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    @note.category_id = params[:category_id]
    @note.selector = params[:selector]
    # @note.title = title_data  
    if @note.save
    # raise @note.id.inspect
      title_data = []  
      @user_data.each do |ud|
        total_val.each do |tv|
          if tv == ud['id']
            u_title = ud['title']
            @profile = Profile.new
            @profile.title = u_title
            @profile.note_id = @note.id
            @profile.save!(validate: false)
            
            #raise @profile.inspect
            # title_data.push u_title  
            # @note.user_id = current_user.id
            # @note.category_id = params[:category_id]
            # @note.selector = params[:selector]
            #@note.save
          end
        end
      end
    end
    # raise @profile.inspect
    redirect_to @note, notice: "Notes was successfully created." 
    # raise total_val.inspect
    # @user_data.each do |ud|
    #   udata = ud['id']
    #   user_data.push udata
    # end
     # @user_data = (params[:note][:selector])
     #raise @user_data.inspect
     # raise params[:user_data].inspect
     # @note.user_id = current_user.id
     # @note.category_id = params[:category_id]
     # @note.selector = params[:selector]
    

     # respond_to do |format|
     #   if @note.save
     #     format.html { redirect_to @note, notice: "Notes was successfully created." }
     #     format.json { render :show, status: :created, location: @note }
     #    #raise response.body.inspect
     #    else
     #      format.html { render :new, status: :unprocessable_entity }
     #      format.json { render json: @note.errors, status: :unprocessable_entity }
     #    end
     #  end
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
  	params.require(:note).permit(:name, :description, :user_id, :selector, :category_id, :title, profiles: [ :title])
  end
end



