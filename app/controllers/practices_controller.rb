require 'net/http'
require 'json'
require 'securerandom'
require 'digest'


class PracticesController < ApplicationController
  before_action :set_practice, only: %i[ show edit update destroy ]

  # GET /practices or /practices.json
  def index
    @practices = Practice.all
  end

  # GET /practices/1 or /practices/1.json
  def show
  end

  # GET /practices/new
  # This record is created automatically when a user or a contest is created
  def new
    @practice = Practice.new
  end

  # GET /practices/1/edit
  def edit
  end

  # POST /practices or /practices.json
  def create
    new_practice_params = practice_params

    # initializing the number of problems by 0
    new_practice_params[:problems] = 0

    @practice = Practice.new(new_practice_params)

    respond_to do |format|
      if @practice.save
        format.html { redirect_to practice_url(@practice), notice: "Practice was successfully created." }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1 or /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to practice_url(@practice), notice: "Practice was successfully updated." }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1 or /practices/1.json
  def destroy
    @practice.destroy

    respond_to do |format|
      format.html { redirect_to practices_url, notice: "Practice was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def update_all_practice_system
    update_all_params = update_params
    # get all trainees in the system
    trainees = User.where(:role => "Trainee")

    # get all the selected_contests contests
    contests = Contest.where(link: update_all_params[:contests_ids])


    codeforces_req_args = {
      :api_key => update_all_params[:api_key],
      :api_secret => update_all_params[:api_secret],
      :handles => trainees.map { |trainee| trainee.codeforces_handle }
    }



    contests.each do |contest|
      puts "iiiiiiiiiiiiiiiiii => "
      codeforces_req_args[:contest_id] = contest.link

      # this should be updated to contest.group
      codeforces_req_args[:group_code] = "zfYO8hvQH4"

      solved_problems = get_num_of_solved_problems codeforces_req_args

      solved_problems.each do |user_handle, num_of_solved_problems |

        # get the trainee with this handle
        trainee = User.where(:codeforces_handle => user_handle).limit(1)[0]

        # get the practice record of this trainee and this contest
        practice = Practice.where(:trainee_id => trainee.id).where(:contest_id => contest.id)[0]

        # update the practice record
        practice.problems= num_of_solved_problems
        practice.save

      end

    end

    redirect_to contests_url

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def practice_params
      params.require(:practice).permit(:trainee_id, :contest_id)
    end


    def update_params
      params
    end

    def get_num_of_solved_problems (args)
      # gets the number of problems this user solved for a specific contest

      # prepare the random number
      rand = SecureRandom.rand(100000)
      rand = rand.to_s.rjust(6, '0')

      # prepare the current time
      current_time = Time.now.to_i.to_s

      # the request parameters sorted alphabetically
      handles = args[:handles].join ";"
      req_params = "apiKey=#{args[:api_key]}&contestId=#{args[:contest_id]}&count=500&from=1&groupCode=#{args[:group_code]}&handles=#{handles}&showUnofficial=true&time=#{current_time}"

      # prepare the signature
      api_sig = rand + '/contest.standings?' + req_params + '#' + args[:api_secret]
      hash = Digest::SHA512.hexdigest(api_sig)
      api_sig = rand + hash

      # send the request
      url = "https://codeforces.com/api/contest.standings?#{req_params}&apiSig=#{api_sig}"
      data = Net::HTTP.get_response(URI(url)).body
      contest_standing = JSON.parse(data)

      # prepare the result map {user_handle, num_of_solved_problems}
      solved_problems = {}
      contest_standing["result"]["rows"].each do | key, val |
        solved_problems[key["party"]["members"][0]["handle"]] = key["points"]
      end

      solved_problems
    end
end
