class Llu < Formula
  desc "Modern C++ wrapper over Wolfram LibraryLink and WSTP"
  homepage "https://wolframresearch.github.io/LibraryLinkUtilities"
  url "https://github.com/WolframResearch/LibraryLinkUtilities/archive/v3.0.1.tar.gz"
  sha256 "1bd66ae3996e86dca4427bf6f9abb46092dc48d502416b52da30b962e62ed742"
  license "MIT"

  depends_on "cmake" => :build

  def install
    inreplace "CMakeLists.txt", "INSTALL_CONFIGDIR cmake/LLU", "INSTALL_CONFIGDIR lib/cmake/LLU"
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
