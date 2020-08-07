class TslArrayHash < Formula
  desc "C++ hash map which preserves the order of insertion"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/array-hash/archive/v0.7.1.tar.gz"
  sha256 "086b4e8adf8c132f2667e5eb6ce21b8707681f5cf95eda8c71d0085126ce5a4b"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
