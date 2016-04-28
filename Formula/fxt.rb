class Fxt < Formula
  desc "Library of low-level algorithms"
  homepage "http://www.jjj.de/fxt/"
  url "http://www.jjj.de/fxt/fxt-2016.04.22.tgz"
  sha256 "e6849384192ceddd0d61b9ca6417e9a885996db4b03464faba7e77eae870c476"

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
