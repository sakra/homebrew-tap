require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Xgrep < Formula
  homepage 'http://wohlberg.net/public/software/xml/xgrep/'
  url 'http://wohlberg.net/public/software/xml/xgrep/xgrep-0.07.tar.gz'
  sha1 '406f2d173dee32fc61703429ce1b160c3d88d87d'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"
  end

end
