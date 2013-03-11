class ExperimentsController < ApplicationController
  # GET /experiments
  # GET /experiments.json
  def index
    @experiments = Experiment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @experiments }
    end
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
    @experiment = Experiment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @experiment }
    end
  end

  # GET /experiments/new
  # GET /experiments/new.json
  def new
    @experiment = Experiment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @experiment }
    end
  end

  # GET /experiments/1/edit
  def edit
    @experiment = Experiment.find(params[:id])
  end

  # POST /experiments
  # POST /experiments.json
  def create
    images = params[:experiment][:image_ids].collect {|x| Image.find(x) if x.length > 0}.compact
    params[:experiment].delete :image_ids
    questions = Question.create_questions_from_images(images)

    @experiment = Experiment.create(params[:experiment])
    @experiment.questions = questions

    respond_to do |format|
      if @experiment.save
        format.html { redirect_to @experiment, notice: 'Experiment was successfully created.' }
        format.json { render json: @experiment, status: :created, location: @experiment }
      else
        format.html { render action: "new" }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /experiments/1
  # PUT /experiments/1.json
  def update
    @experiment = Experiment.find(params[:id])

    respond_to do |format|
      if @experiment.update_attributes(params[:experiment])
        format.html { redirect_to @experiment, notice: 'Experiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.json
  def destroy
    @experiment = Experiment.find(params[:id])
    @experiment.destroy

    respond_to do |format|
      format.html { redirect_to experiments_url }
      format.json { head :no_content }
    end
  end

  def launch_exp
    experiment = Experiment.find(params[:id])
    @turkee_task = Turkee::TurkeeTask.new
  end

  def get_results
    @questions = Experiment.find(params[:id]).questions
    respond_to do |format|
      format.csv { send_data @questions.generate_csv(params[:id])}
    end
  #  @responses = Experiment.find(params[:id]).responses
  #  respond_to do |format|
  #    format.csv { send_data @responses.generate_csv}
  #  end
  end
end
