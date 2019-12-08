class FastHarm < FourierTransformData
  private

  def harmonic_amplitude
    @harmonic_amplitude ||= (0..harmonics-1).map do |k|
      fft_matrix[k].magnitude / harmonics
    end
  end

  def initial_phase
    @initial_phase ||= (0..harmonics-1).map do |k|
      Math.atan2(fft_matrix[k].imaginary, fft_matrix[k].real)
    end
  end

  def fft_matrix
    @fft_matrix ||= FastFourierTransform.new(n).fft(basic_sygnal)
  end
end
