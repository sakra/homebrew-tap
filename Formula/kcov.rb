class Kcov < Formula
  desc "Code coverage tool for compiled programs, Python and Bash"
  homepage "http://simonkagstrom.github.com/kcov/index.html"
  url "https://github.com/SimonKagstrom/kcov/archive/v36.tar.gz"
  sha256 "29ccdde3bd44f14e0d7c88d709e1e5ff9b448e735538ae45ee08b73c19a2ea0b"

  depends_on "cmake" => :build
  depends_on "binutils"
  depends_on "pkg-config"

  def install
    ENV.append "CXXFLAGS", "-O2"
    ENV.append "CXXFLAGS", "-I#{Formula["binutils"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["binutils"].opt_lib}"
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
