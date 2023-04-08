class ContestsController < ApplicationController
  before_action :set_contest, only: %i[ show edit update destroy ]


  # board only can create, read, update
  before_action :require_board, only: %i[ new create edit update destroy ]

  # users with accounts only can view
  before_action :require_login, except: %i[ new create edit update destroy ]

  # GET /contests or /contests.json
  def index
    @contests = Contest.all
  end

  # GET /contests/1 or /contests/1.json
  def show
  end

  # GET /contests/new
  def new
    @contest = Contest.new
  end

  # GET /contests/1/edit
  def edit
  end

  # POST /contests or /contests.json
  def create
    new_contest_params = contest_params
    new_contest_params[:user_id] = session[:user_id]

    @contest = Contest.new(new_contest_params)

    respond_to do |format|
      if @contest.save
        # get all the Trainees ids
        trainees_ids = User.where(role: "Trainee").pluck :id

        # create a practice record for each user
        trainees_ids.each do | trainee_id |
          Practice.new contest: @contest.id, trainee: trainee_id, problems: 0
        end


        format.html { redirect_to contest_url(@contest), notice: "Contest was successfully created." }
        format.json { render :show, status: :created, location: @contest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end




  def update_practice
    @contests = Contest.all
    render :update_practice
  end

  # PATCH/PUT /contests/1 or /contests/1.json
  def update
    respond_to do |format|
      if @contest.update(contest_params)
        format.html { redirect_to contest_url(@contest), notice: "Contest was successfully updated." }
        format.json { render :show, status: :ok, location: @contest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contests/1 or /contests/1.json
  def destroy
    @contest.destroy

    respond_to do |format|
      format.html { redirect_to contests_url, notice: "Contest was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contest
      @contest = Contest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contest_params
      params.require(:contest).permit(:name, :link, :start_at)
    end
end
