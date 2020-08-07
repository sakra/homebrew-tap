class Eastl < Formula
  desc "Electronic Arts Standard Template Library"
  homepage "https://github.com/electronicarts/EASTL"
  url "https://github.com/electronicarts/EASTL.git",
      using:    :git,
      tag:      "3.16.07",
      revision: "1cf6182218bec79ece0b91e762f507e8c027807c"
  sha256 ""

  depends_on "cmake" => :build

  def install
    system "git", "submodule", "update", "--init"
    system "cmake", std_cmake_args, "-S.", "-Bbuild"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
