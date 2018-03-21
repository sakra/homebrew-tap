require 'formula'

class Gtest < Formula
  skip_clean "lib"
  url 'https://github.com/google/googletest/archive/release-1.8.0.tar.gz'
  homepage 'https://github.com/google/googletest'
  sha256 '58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8'

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
