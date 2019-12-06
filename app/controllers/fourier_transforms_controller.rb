class FourierTransformsController < ApplicationController
  def new
    @fourier_transform = FourierTransform.new
  end

  def create
    @fourier_transform = FourierTransform.new(fourier_transform_parameters)

    @fourier_transform.save
    redirect_to fourier_transform_path(@fourier_transform)
  end

  def show
    @basic = fourier_transform_service.harmonic
    @a_spektr = fourier_transform_service.a_spectr
    @phase_spektr = fourier_transform_service.phase_spectr

    @polyharmonic = fourier_transform_polyharmonic_service.polyharmonics
    @a_spektr_poly = fourier_transform_polyharmonic_service.a_spectr_polyharmonical
    @phase_spektr_poly = fourier_transform_polyharmonic_service.phase_spectr_polyharmonical

    @filter_harm = filter_service.filter_graphic
    @filter_polyharm = filter_harmonic_service.filter_graphic
  end

  private

  def fourier_transform_data
    @fourier_transform_data ||= FourierTransform.find(params[:id])
  end

  def fourier_transform_parameters
    params.require(:fourier_transform).permit(:N)
  end

  def fourier_transform_service
    @fourier_transform_service ||= FourierTransformData.new(fourier_transform_data.N)
  end

  def fourier_transform_polyharmonic_service
    @fourier_transform_polyharmonic_service ||= FourierTransformPolyharmonicData.new(fourier_transform_data.N)
  end

  def filter_service
    @filter_service ||= FilterData.new(fourier_transform_data.N)
  end

  def filter_harmonic_service
    @filter_harmonic_service ||= FilterHarmonicData.new(fourier_transform_data.N)
  end
end
