class Llu < Formula
  desc "Modern C++ wrapper over Wolfram LibraryLink and WSTP"
  homepage "https://wolframresearch.github.io/LibraryLinkUtilities"
  url "https://github.com/WolframResearch/LibraryLinkUtilities/archive/v3.1.0.tar.gz"
  sha256 "8cd83f8fd471452abaf0870a771ebe19a9bbdafe1b40191ee18de77d9d1c5afd"
  license "MIT"

  depends_on "cmake" => :build

  def install
    inreplace "CMakeLists.txt", "INSTALL_CONFIGDIR cmake/LLU", "INSTALL_CONFIGDIR lib/cmake/LLU"
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
