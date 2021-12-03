module InputReader
  INPUT_FILES = {
    input: 'input.txt',
    sample: 'sample.txt'
  }.freeze

  def self.read
    path = INPUT_FILES[ARGV[0]&.to_sym || :input]
    File.readlines path, chomp: true
  end
end
