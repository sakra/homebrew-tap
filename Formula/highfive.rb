class Highfive < Formula
  desc "Header-only C++ HDF5 interface"
  homepage "https://github.com/BlueBrain/HighFive"
  url "https://github.com/BlueBrain/HighFive/archive/v2.2.tar.gz"
  sha256 "fe065f2443e38444100b43999a96916e81a0aa7e500cf768d3bf6f8392b8efee"

  depends_on "cmake" => :build

  depends_on "boost"
  depends_on "hdf5"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
