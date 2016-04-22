class Nwcc < Formula
  homepage "http://nwcc.sourceforge.net/index.html"
  url "http://downloads.sourceforge.net/project/nwcc/nwcc/nwcc%200.8.3/nwcc_0.8.3.tar.gz"
  version "0.8.3"
  sha1 "2ab1825dc1f8bd5258204bab19e8fafad93fef26"

  def install
    system "./configure", "--installprefix=#{prefix}"
    system "make"
    system "make", "install"
    doc.install 'CROSSCOMP', 'USAGE', 'README.first' => 'README'
  end

end
