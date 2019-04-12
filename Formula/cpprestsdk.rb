class Cpprestsdk < Formula
  desc "C++ libraries for cloud-based client-server communication"
  homepage "https://github.com/Microsoft/cpprestsdk"
  url "https://github.com/Microsoft/cpprestsdk/archive/v2.10.12.tar.gz"
  sha256 "c7c2a5deb4cad036b974e9b7f2ba2e3ae829312894ddfca2fae3a11980fef63e"
  head "https://github.com/Microsoft/cpprestsdk.git", :branch => "development"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "openssl"

  def install
    system "cmake", ".", "-DBUILD_SAMPLES=OFF", "-DBUILD_TESTS=OFF",
      "-DCPPREST_EXCLUDE_WEBSOCKETS=ON", "-DWERROR=OFF", *std_cmake_args
    system "make", "install"
  end

end
