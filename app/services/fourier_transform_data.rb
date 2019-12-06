class FourierTransformData
  attr_reader :n, :harmonics

  def initialize(n)
    @n = n.to_i
    @harmonics = n.to_i / 2
  end

  def harmonic
    [basic_graphic, restored_graphic]
  end

  def basic_graphic
    {name: "Basic Sygnal", data: basic_sygnal.map.with_index { |sample, i| [i, sample] }}
  end

  def restored_graphic
    {name: "Restored Sygnal", data: restored_sygnal.map.with_index { |sample, i| [i, sample] }}
  end

  def a_spectr
    [{name: "A Spectrum", data: harmonic_amplitude.map.with_index { |sample, i| [i, sample] }}]
  end

  def phase_spectr
    [{name: "Phase Spectrum", data: initial_phase.map.with_index { |sample, i| [i, sample] }}]
  end

  def basic_sygnal
    @basic_samples ||= (0..n-1).map { |i| sample(i) }
  end

  private

  def restored_sygnal
    @restored_sygnal ||= (0..n-1).map { |i| restored_sample(i) }
  end

  def sample(i)
    20 * Math.cos(2 * Math::PI * 10 * i / n)
  end

  def restored_sample(i)
    (0..harmonics - 1).map do |k|
      harmonic_amplitude[k] * Math.cos(2 * Math::PI * k * i / n - initial_phase[k])
    end.sum
  end

  def harmonic_amplitude
    @harmonic_amplitude ||= (0..harmonics-1).map do |k|
      Math.sqrt(sA[k]**2 + cA[k]**2)
    end
  end

  def initial_phase
    @initial_phase ||= (0..harmonics-1).map do |k|
      Math.atan2(sA[k], cA[k])
    end
  end

  def sA
    @sA ||= (0..harmonics-1).map do |k|
      sum = (0..n-1).map { |i| basic_sygnal[i] * Math.sin(2 * Math::PI * k * i / n) }.sum
      2 / n.to_f * sum
    end
  end

  def cA
    @cA ||= (0..harmonics-1).map do |k|
      sum = (0..n-1).map { |i| basic_sygnal[i] * Math.cos(2 * Math::PI * k * i / n) }.sum
      2 / n.to_f * sum
    end
  end
end
