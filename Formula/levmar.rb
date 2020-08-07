class Levmar < Formula
  desc "Levenberg-Marquardt nonlinear least squares algorithms"
  homepage "http://users.ics.forth.gr/~lourakis/levmar/"
  url "http://users.ics.forth.gr/~lourakis/levmar/levmar-2.6.tgz"
  sha256 "3bf4ef1ea4475ded5315e8d8fc992a725f2e7940a74ca3b0f9029d9e6e94bad7"

  depends_on "clapack"

  def install
    clapack = Formula["clapack"]
    ENV.append "CFLAGS", "-I#{clapack.include}/clapack"
    ENV.append "LDFLAGS", "-L#{clapack.lib}/clapack -L."
    inreplace "Makefile" do |s|
      s.change_make_var! "CC", ENV["CC"]
      s.change_make_var! "CFLAGS", ENV["CFLAGS"]
      s.change_make_var! "LDFLAGS", ENV["LDFLAGS"]
      s.change_make_var! "LAPACKLIBS", "-lclapack -lcblas -lf2c"
    end
    system "make"
    (include + name).install Dir["*.h"]
    lib.install "liblevmar.a"
  end
end
