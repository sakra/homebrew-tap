class Fxt < Formula
  desc "Library of low-level algorithms"
  homepage "http://www.jjj.de/fxt/"
  url "http://www.jjj.de/fxt/fxt-2015.08.31.tgz"
  sha256 "2fa6551a9b0bf5f1f4836d33ed17fb9b7b99171f28db46cd477209f8f4f3e4a9"

  option :universal
  option :cxx11

  def install
    ENV.deparallelize
    ENV.universal_binary if build.universal?
    ENV.O2
    ENV.cxx11 if build.cxx11?
    lib.mkdir
    include.mkdir
    system "make", "install", "PREFIX=#{prefix}", "CXXFLAGS=#{ENV.cxxflags}", "CXX=#{ENV.cxx}", "FXT_INSTALL=/usr/bin/install"
  end

end
