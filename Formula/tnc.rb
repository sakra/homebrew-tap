class Tnc < Formula
  desc "Truncated-Newton optimization package"
  homepage "http://js2007.free.fr/code/#TNC"
  url "http://js2007.free.fr/code/tnc-1.3.gz"
  sha256 "d110b1ed35266aacd6a8dca237ae683aabd5d61a1097f5c99af278070bf53f06"

  def install
    ENV.fast
    system "#{ENV.cc} #{ENV.cflags} -c tnc.c"
    system "libtool -static -o libtnc.a tnc.o"
    include.install "tnc.h"
    lib.install "libtnc.a"
  end
end
