class Vc < Formula
  desc "SIMD Vector Classes for C++"
  homepage "https://github.com/VcDevel"
  url "https://github.com/VcDevel/Vc/releases/download/1.3.3/Vc-1.3.3.tar.gz"
  sha256 "08c629d2e14bfb8e4f1a10f09535e4a3c755292503c971ab46637d2986bdb4fe"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

end
