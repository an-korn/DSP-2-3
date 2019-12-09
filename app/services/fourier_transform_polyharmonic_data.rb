class FourierTransformPolyharmonicData < FourierTransformData
  M = 30
  A = [1,3,4,10,11,14,17]
  Phi = [Math::PI/6, Math::PI/4, Math::PI/3, Math::PI/2, 3*Math::PI/4, Math::PI]

  def polyharmonics
    [polyharmonical_graphic, polyharmonical_restored_sygnal_graphic]
  end

  def polyharmonical_graphic
    {name: "Polyharmonical Sygnal", data: polyharmonical_sygnal.map.with_index { |sample, i| [i, sample] }}
  end

  def a_spectr_polyharmonical
    [{name: "A Spectrum Polyharmonical", data: harmonic_amplitude.map.with_index { |sample, i| [i, sample] }}]
  end

  def phase_spectr_polyharmonical
    [{name: "Phase Spectrum Polyharmonical", data: initial_phase.map.with_index { |sample, i| [i, sample] }}]
  end

  def polyharmonical_restored_sygnal_graphic
    {name: "Polyharmonical Restored Sygnal", data: polyharmonical_restored_sygnal.map.with_index { |sample, i| [i, sample] }}
  end

  def polyharmonical_restored_sygnal_without_phase_graphic
    {name: "Polyharmonical Restored Sygnal Without Phase", data: polyharmonical_restored_sygnal_without_phase.map.with_index { |sample, i| [i, sample] }}
  end

  def polyharmonical_sygnal
    @polymorphical_sygnal ||= (0..n-1).map { |i| polyharmonical_sample(i) }
  end

  private

  def polyharmonical_restored_sygnal
    @polymorphical_restored_sygnal ||= (0..n).map do |i|
      harmonic_amplitude[0]/2 + polyharmonical_restored_sample(i)
    end
  end

  def polyharmonical_restored_sygnal_without_phase
    @polyharmonical_restored_sygnal_without_phase ||= (0..n).map do |i|
      harmonic_amplitude[0]/2 + polyharmonical_restored_without_phase_sample(i)
    end
  end

  def polyharmonical_sample(i)
    (0..M-1).map { |k| a_sample[k] * Math.cos(2 * Math::PI * k * i / n - phase_sample[k]) }.sum
  end

  def polyharmonical_restored_sample(i)
    (0..harmonics-1).map do |k|
      harmonic_amplitude[k] * Math.cos(2 * Math::PI * k * i / n - initial_phase[k])
    end.sum
  end

  def polyharmonical_restored_without_phase_sample(i)
    (0..harmonics-1).map do |k|
      harmonic_amplitude[k] * Math.cos(2 * Math::PI * k * i / n)
    end.sum
  end

  def sA
    @sA ||= (0..harmonics-1).map do |k|
      sum = (0..n-1).map { |i| polyharmonical_sygnal[i] * Math.sin(2 * Math::PI * k * i / n) }.sum
      2 / n.to_f * sum
    end
  end

  def cA
    @cA ||= (0..harmonics-1).map do |k|
      sum = (0..n-1).map { |i| polyharmonical_sygnal[i] * Math.cos(2 * Math::PI * k * i / n) }.sum
      2 / n.to_f * sum
    end
  end

  def a_sample
    @a_sample ||= (0..M-1).map { |_| A.sample }
  end

  def phase_sample
    @phase_sample ||= (0..M-1).map { |_| Phi.sample }
  end
end
