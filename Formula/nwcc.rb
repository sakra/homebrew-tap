class Nwcc < Formula
  homepage "http://nwcc.sourceforge.net/index.html"
  url "http://downloads.sourceforge.net/project/nwcc/nwcc/nwcc%200.8.3/nwcc_0.8.3.tar.gz"
  version "0.8.3"
  sha256 "e64b16c663f2f845d6436342722d29a5e32d03602971de2d521281a18188b065"

  def install
    system "./configure", "--installprefix=#{prefix}"
    system "make"
    system "make", "install"
    doc.install 'CROSSCOMP', 'USAGE', 'README.first' => 'README'
  end

end
