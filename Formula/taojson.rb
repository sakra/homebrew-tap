class Taojson < Formula
  desc "C++ header-only JSON library"
  homepage "https://taocpp.github.io/"
  url "https://github.com/taocpp/json/archive/1.0.0-beta.12.tar.gz"
  sha256 "92692225b0b6b217948ee7f3bf176f5a2a168b9a616d09c080ea571b9dfbd4a7"
  license "MIT"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
