class TslOrderedMap < Formula
  desc "C++ hash map which preserves the order of insertion"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/ordered-map/archive/v1.0.0.tar.gz"
  sha256 "49cd436b8bdacb01d5f4afd7aab0c0d6fa57433dfc29d65f08a5f1ed1e2af26b"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
