class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  def get_operations
    operations = []
    @arrow_pass ||= RestClient::Resource.new(
      Settings.arrow_pass_host,
      headers: {
        "APS-IDENTIFIER" => Settings.client.app_key
      }
    )
    
    response = @arrow_pass["/api/device/operations.json"].get
    
    json = JSON.parse(response.body)
    if json.is_a?(Array)
      json.each do |operation|
        operations.push("function_name: #{operation["function_name"]}(#{operation["options"]})")
        Operation.create!(
          ap_id: operation["id"],
          function_name: operation["function_name"],
          options: operation["options"]
        )
      end
    end  
    
    if operations.empty?
      flash[:operations] = 'No new operations'
    else  
      flash[:operations] = operations.join('<br />')
    end  
    redirect_to root_path
  end

  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations
  # POST /operations.json
  def create
    @operation = Operation.new(operation_params)

    respond_to do |format|
      if @operation.save
        format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_params
      params.require(:operation).permit(:function_name)
    end
end
