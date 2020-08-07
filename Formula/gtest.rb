class Gtest < Formula
  desc "Google's C++ test framework"
  homepage "https://github.com/google/googletest"
  url "https://github.com/google/googletest/archive/release-1.8.0.tar.gz"
  sha256 "58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8"

  depends_on "cmake" => :build
  skip_clean "lib"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
