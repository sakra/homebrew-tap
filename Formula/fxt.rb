class Fxt < Formula
  desc "Library of low-level algorithms"
  homepage "https://www.jjj.de/fxt/"
  url "https://www.jjj.de/fxt/fxt-2020.01.29.tar.gz"
  sha256 ""

  option :cxx11

  def install
    ENV.deparallelize
    ENV.O2
    ENV.cxx11
    lib.mkdir
    include.mkdir
    system "make", "install", "PREFIX=#{prefix}", "CXXFLAGS=#{ENV.cxxflags}", "CXX=#{ENV.cxx}", "FXT_INSTALL=/usr/bin/install"
  end

end
