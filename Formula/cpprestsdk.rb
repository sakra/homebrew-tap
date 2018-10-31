class Cpprestsdk < Formula
  desc "C++ libraries for cloud-based client-server communication"
  homepage "https://github.com/Microsoft/cpprestsdk"
  url "https://github.com/Microsoft/cpprestsdk/archive/v2.10.7.tar.gz"
  sha256 "1fc7ef2a967b7ec2b6e82d0452e894341ce97ae6a26828dd29ad14378c8aeece"
  head "https://github.com/Microsoft/cpprestsdk.git", :branch => "development"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "openssl"

  def install
    system "cmake", "-DBUILD_SAMPLES=OFF", "-DBUILD_TESTS=OFF", "-DBUILD_SHARED_LIBS=OFF",
      "-DCPPREST_EXCLUDE_WEBSOCKETS=ON", "-DWERROR=OFF" "Release", *std_cmake_args
    system "make", "install"
  end

end
