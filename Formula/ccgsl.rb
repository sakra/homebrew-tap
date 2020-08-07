class Ccgsl < Formula
  desc "C++ interface for the gnu Scientific Library"
  homepage "https://ccgsl.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ccgsl/ccgsl-1.16.1.tar.gz"
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
