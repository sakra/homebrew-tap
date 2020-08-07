class Libdivide < Formula
  desc "Optimizing integer division"
  homepage "http://libdivide.com/"
  url "https://github.com/ridiculousfish/libdivide/archive/v1.0.tar.gz"
  sha256 "a34693b9b4807d79dfde047d9279a798c1ff36603e257d17f17aea25d06aa2bf"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
