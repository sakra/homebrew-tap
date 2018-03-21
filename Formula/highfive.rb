class Highfive < Formula
  desc "HighFive - Header-only C++ HDF5 interface"
  homepage "https://github.com/BlueBrain/HighFive"
  url "https://github.com/BlueBrain/HighFive/archive/v1.5.tar.gz"
  sha256 "f194bda482ab15efa7c577ecc4fb7ee519f6d4bf83470acdb3fb455c8accb407"
  
  depends_on "boost"
  depends_on "hdf5"
  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
