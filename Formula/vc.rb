class Vc < Formula
  desc "SIMD Vector Classes for C++"
  homepage "https://github.com/VcDevel"
  url "https://github.com/VcDevel/Vc/releases/download/1.4.1/Vc-1.4.1.tar.gz"
  sha256 "68e609a735326dc3625e98bd85258e1329fb2a26ce17f32c432723b750a4119f"

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end
end
