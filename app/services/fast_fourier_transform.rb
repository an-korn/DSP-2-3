class FastFourierTransform
  attr_reader :n, :harmonics

  def initialize(n)
    @n = n.to_i
    @harmonics = n.to_i / 2
  end

  def fft(signal)
    return signal if signal.size <= 1

    even = Array.new(signal.size / 2) { |i| signal[2 * i] }
    odd  = Array.new(signal.size / 2) { |i| signal[2 * i + 1] }

    fft_even = fft(even)
    fft_odd  = fft(odd)

    fft_even.concat(fft_even)
    fft_odd.concat(fft_odd)

    Array.new(signal.size) {|i| fft_even[i] + fft_odd[i] * omega(-i, signal.size)}
  end

  private

  def omega(k, n)
    Math::E ** Complex(0, 2 * Math::PI * k / n)
  end
end
