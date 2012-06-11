class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    all_tasks
    @task            = Task.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = tasks.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    all_tasks
    @task = tasks.find(params[:id])
    status = params[:status]
    if ['pending','completed'].include?(status)  
      @task.update_status(status)
      redirect_to tasks_url, notice: 'Task was successfully updated.' and return
    end
    render 'index' and return
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = tasks.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        all_tasks
        format.html { render action: "index" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        tasks
        format.html { render action: "index" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
  
  private
  def tasks
    @current_user.tasks
  end
  
  def all_tasks
    @pending_tasks   = tasks.pending
    @completed_tasks = tasks.completed
  end

end
