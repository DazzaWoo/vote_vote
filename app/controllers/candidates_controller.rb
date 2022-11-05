class CandidatesController < ApplicationController
  before_action :find_candidate, only: %i[show, edit, update, destroy]

  def index
    @candidates = Candidate.all
  end

  def new
    @candidate = Candidate.new
  end

  def create
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      redirect_to candidates_path, notice: 'Candidates has been created!'
    else
      render :new
    end
  end

  def show
    find_candidate
  end

  def edit
    find_candidate
  end

  def update
    find_candidate
    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: 'Candidate has been updated!'
    else
      render :edit
    end
  end

  def destroy
    find_candidate
    @candidate.destroy
    redirect_to candidate_path, notice: 'Candidate has been destroied!'
  end

  def vote
    find_candidate
    # @candidate.increment(:votes)
    # @candidate.save
    @candidate.vote_logs.create(ip_address: request.remote_ip)
    redirect_to candidates_path, notice: 'vote succeeded'
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :party, :age, :politics)
  end

  def find_candidate
    @candidate = Candidate.find(params[:id])
  end
end
