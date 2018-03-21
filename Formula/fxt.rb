class Fxt < Formula
  desc "Library of low-level algorithms"
  homepage "https://www.jjj.de/fxt/"
  url "https://www.jjj.de/fxt/fxt-2018.02.15.tar.gz"
  sha256 "17a4e22556203d0b3f08a0f762d91b4dcbc8ff2b91262c0b85f5de6c6e489e0b"

  option :cxx11

  def install
    ENV.deparallelize
    ENV.O2
    ENV.cxx11 if build.cxx11?
    lib.mkdir
    include.mkdir
    system "make", "install", "PREFIX=#{prefix}", "CXXFLAGS=#{ENV.cxxflags}", "CXX=#{ENV.cxx}", "FXT_INSTALL=/usr/bin/install"
  end

end
