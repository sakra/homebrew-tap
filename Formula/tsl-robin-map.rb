class TslRobinMap < Formula
  desc "C++ hash map which preserves the order of insertion"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/robin-map/archive/v0.6.3.tar.gz"
  sha256 "e6654c8c2598f63eb0b1d52ff8bdf39cfcc91d81dd5d05274a6dca91241cd72f"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
