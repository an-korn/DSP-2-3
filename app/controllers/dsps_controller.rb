class DspsController < ApplicationController
  def new
    @dsp = Dsp.new
  end

  def create
    @dsp = Dsp.new(dsp_parameters)

    @dsp.save
    redirect_to dsp_path(@dsp)
  end

  def show
    @data = GenerateGraphicData.call(dsp_data.N, dsp_data.K, dsp_data.Phi)
  end

  private

  def dsp_data
    @dsp_data ||= Dsp.find(params[:id])
  end

  def dsp_parameters
    params.require(:dsp).permit(:N, :K, :Phi)
  end
end
