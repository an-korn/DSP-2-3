class GenerateGraphicData
  attr_reader :n, :k, :phi

  Result = Struct.new(:setA, :setM, :setSKZ_1, :setSKZ_2)

  def initialize(n, k, phi)
    @n = n
    @k = k
    @phi = phi
  end

  def self.call(n, k, phi)
    new(n, k, phi).call
  end

  def call
    [amplitude_graphic, skz_1_graphic, skz_2_graphic]
  end

  private

  def amplitude_graphic
    {name: "Amplitude", data: generated_data.setA.map { |a| [a[1], 1 - a[0]] }}
  end

  def skz_1_graphic
    {name: "SKZ 1", data: generated_data.setSKZ_1.map { |skz| [skz[1], 0.707 - skz[0]] }}
  end

  def skz_2_graphic
    {name: "SKZ 2", data: generated_data.setSKZ_2.map { |skz| [skz[1], 0.707 - skz[0]] }}
  end

  def generated_data
    @generated_data ||= begin
      setA = []
      setM = []
      setSKZ_1 = []
      setSKZ_2 = []
      (k.to_i..5*n.to_i).each do |m|
        cos, sin, itemX = 0.0, 0.0, 0.0
        sumItemX, sumSquareItemX = 0, 0
        (1..m-1).each do |l|
          itemX = Math.sin(2 * Math::PI * l/ n.to_i + phi.to_f)
          sumItemX += itemX
          sumSquareItemX += itemX**2
          sin += itemX * Math.sin(2 * Math::PI * l / m)
          cos += itemX * Math.cos(2 * Math::PI * l / m)
        end
        b  = 2 * sin / m
        a  = 2 * cos / m
        setA << [Math.sqrt(a**2 + b**2), m]
        tmp = sumSquareItemX / (m + 1)
        setSKZ_1 << [Math.sqrt(tmp), m]
        tmp = tmp - (sumItemX / (m + 1))**2
        setSKZ_2 << [Math.sqrt(tmp), m]
        setM << m
      end
      Result.new(setA, setM, setSKZ_1, setSKZ_2)
    end
  end
end
