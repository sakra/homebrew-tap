class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL/archive/3.08.00.tar.gz"
  sha256 "14f89bdeb0b0ed316408572f7250ce80710f32e42ec4fd1e550f43bb2cf74f90"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
