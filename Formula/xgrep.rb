class Xgrep < Formula
  desc "Grep-like utility for XML files"
  homepage "http://wohlberg.net/public/software/xml/xgrep/"
  url "http://wohlberg.net/public/software/xml/xgrep/xgrep-0.08.tar.gz"
  sha256 "41894e5b1d0ab53258fb67ddd6b2cecf418c6bc02033c42e8160cc658faad5b7"

  depends_on "makedepend" => :build

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
