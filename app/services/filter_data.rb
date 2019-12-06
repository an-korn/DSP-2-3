class FilterData < FourierTransformPolyharmonicData
  LOW_FREQ = 3
  HIGH_FREQ = 7

  def filter_graphic
    [polyharmonical_graphic, band_pass_graphic, low_graphic, high_graphic]
  end

  def band_pass_graphic
    {name: "Band-Pass Filter", data: band_pass.map.with_index { |sample, i| [i, sample] }}
  end

  def low_graphic
    {name: "Low Frequency Filter", data: low.map.with_index { |sample, i| [i, sample] }}
  end

  def high_graphic
    {name: "High Frequency Filter", data: high.map.with_index { |sample, i| [i, sample] }}
  end

  private

  def band_pass
    @band_pass ||= (1..n-1).map do |i|
      harmonic_amplitude[0]/2 + filtered_sample(i, LOW_FREQ, HIGH_FREQ)
    end
  end

  def low
    @low ||= (1..n-1).map do |i|
      harmonic_amplitude[0]/2 + filtered_sample(i, 0, LOW_FREQ)
    end
  end

  def high
    @high ||= (1..n-1).map do |i|
      harmonic_amplitude[0]/2 + filtered_sample(i, HIGH_FREQ, harmonics)
    end
  end

  def filtered_sample(i, min, max)
    (min..max-1).map do |k|
      harmonic_amplitude[k] * Math.cos(2 * Math::PI * k * i / n - initial_phase[k])
    end.sum
  end
end
