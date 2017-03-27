class Cminpack < Formula
  desc "Solves nonlinear equations and nonlinear least squares problems"
  homepage "http://devernay.free.fr/hacks/cminpack/cminpack.html"
  url "https://github.com/devernay/cminpack/archive/v1.3.6.tar.gz"
  sha256 "3c07fd21308c96477a2c900032e21d937739c233ee273b4347a0d4a84a32d09f"
  head "https://github.com/devernay/cminpack.git"

  depends_on "cmake" => :build
  depends_on "openblas" unless OS.mac?

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"

    man3.install Dir["doc/*.3"]
    doc.install Dir["doc/*"]
    pkgshare.install "examples"

    lib64 = Pathname.new "#{lib}64"
    mv lib64, lib if lib64.directory?
  end

  test do
    cp pkgshare/"examples/thybrdc.c", testpath
    system ENV.cc, "-o", testpath/"thybrdc", "-I#{include}/cminpack-1", "thybrdc.c", "-L#{lib}", "-lcminpack", "-lm"
    system testpath/"thybrdc"
  end
end
