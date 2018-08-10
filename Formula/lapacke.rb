require 'formula'

class Lapacke < Formula
  desc "Standard C language API for LAPACK"
  homepage 'https://github.com/Reference-LAPACK/lapack'
  url 'https://github.com/Reference-LAPACK/lapack/archive/v3.8.0.tar.gz'
  sha256 'deb22cc4a6120bff72621155a9917f485f96ef8319ac074a7afbc68aab88bcf6'

  keg_only :provided_by_macos

  depends_on "cmake" => :build
  depends_on "gcc" # for gfortran

  def install
    ENV.delete("MACOSX_DEPLOYMENT_TARGET")

    mkdir "build" do
      system "cmake", "..",
                      "-DBUILD_SHARED_LIBS:BOOL=OFF",
                      "-DBUILD_DEPRECATED:BOOL=ON",
                      "-DCBLAS:BOOL=ON",
                      "-DLAPACKE:BOOL=ON",
                      *std_cmake_args
      system "make", "install"
    end
  end

end
