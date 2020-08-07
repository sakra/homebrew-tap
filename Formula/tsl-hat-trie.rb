class TslHatTrie < Formula
  desc "C++ hash map which preserves the order of insertion"
  homepage "https://tessil.github.io/"
  url "https://github.com/Tessil/hat-trie/archive/v0.6.0.tar.gz"
  sha256 "f3793fd46f07bdf3de67d719b602c84f66121d81aa02d9e6d53de03ae3444c80"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
