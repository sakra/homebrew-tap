class TslHopscotchMap < Formula
  desc "C++ implementation of a fast hash map using hopscotch hashing"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/hopscotch-map/archive/v2.3.0.tar.gz"
  sha256 "a59d65b552dc7682521989842418c92257147f5068152b5af50e917892ad9317"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
