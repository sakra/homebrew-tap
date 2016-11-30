class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL/archive/3.04.00.tar.gz"
  sha256 "3f37fbadd34d35c4260fafab8ff9c0e9e3ebffba7f6d6dbd4f43d02aa56e27b6"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
