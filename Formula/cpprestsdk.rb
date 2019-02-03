class Cpprestsdk < Formula
  desc "C++ libraries for cloud-based client-server communication"
  homepage "https://github.com/Microsoft/cpprestsdk"
  url "https://github.com/Microsoft/cpprestsdk/archive/v2.10.10.tar.gz"
  sha256 "55e1521fb7b7c9b2f4f2065c5fb47e249227f15299257ee6f1a0c942a4057f4f"
  head "https://github.com/Microsoft/cpprestsdk.git", :branch => "development"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "openssl"

  def install
    system "cmake", ".", "-DBUILD_SAMPLES=OFF", "-DBUILD_TESTS=OFF", "-DBUILD_SHARED_LIBS=OFF",
      "-DCPPREST_EXCLUDE_WEBSOCKETS=ON", "-DWERROR=OFF", *std_cmake_args
    system "make", "install"
  end

end
