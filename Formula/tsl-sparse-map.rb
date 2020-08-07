class TslSparseMap < Formula
  desc "C++ hash map which preserves the order of insertion"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/sparse-map/archive/v0.6.2.tar.gz"
  sha256 "7020c21e8752e59d72e37456cd80000e18671c803890a3e55ae36b295eba99f6"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
