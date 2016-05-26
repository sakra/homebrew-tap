class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL/archive/3.01.01.tar.gz"
  sha256 "6414174d5553c3c7afa78cb0ded637810d49fbddafff1ef96e63bd396b56f0b4"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
