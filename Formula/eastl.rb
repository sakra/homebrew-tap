class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL/archive/3.13.04.tar.gz"
  sha256 "1f6279fb4347cbe2c28a7d4f62401db9347686b8e940b02ac8bb67b080f0324f"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

end
