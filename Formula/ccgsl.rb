class Ccgsl < Formula
  homepage "http://ccgsl.sourceforge.net/"
  url "http://downloads.sourceforge.net/project/ccgsl/ccgsl-1.16.1.tar.gz"
  version "1.16.1"
  sha256 "6a846749ed35eaa0844935356450c5590d53e40a70ac596ef6718d89652509f1"

  depends_on "gsl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

end
