class Cpprestsdk < Formula
  desc "C++ libraries for cloud-based client-server communication"
  homepage "https://github.com/Microsoft/cpprestsdk"
  url "https://github.com/Microsoft/cpprestsdk/archive/v2.10.6.tar.gz"
  sha256 "5fecccc779b077f18acf0f7601b19b39c3da963498ed5b10bb2700dccfe66c5a"
  head "https://github.com/Microsoft/cpprestsdk.git", :branch => "master"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "openssl"

  def install
    system "cmake", "-DBUILD_SAMPLES=OFF", "-DBUILD_TESTS=OFF", "-DBUILD_SHARED_LIBS=OFF",
      "-DCPPREST_EXCLUDE_WEBSOCKETS=ON", "-DWERROR=OFF" "Release", *std_cmake_args
    system "make", "install"
  end

end
