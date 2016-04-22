require 'formula'

class Tnc <Formula
  url 'http://js2007.free.fr/code/tnc-1.3.gz'
  homepage 'http://js2007.free.fr/code/#TNC'
  md5 '782452594bd0a4894e19142fc97a451c'

  def install
    ENV.fast
    system "#{ENV.cc} #{ENV.cflags} -c tnc.c"
    system "libtool -static -o libtnc.a tnc.o"
    include.install "tnc.h"
    lib.install "libtnc.a"
  end
end
