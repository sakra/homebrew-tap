class F2c < Formula
  desc "Fortran-to-C Converter"
  homepage "http://www.netlib.org/f2c/"
  url "http://www.netlib.org/f2c/src.tgz"
  version "201601021"
  sha256 "791836946719aca39a5fb0f13db0b891059af220595fd516b509c1c3eaaa3d5e"

  resource "lib" do
    url "http://www.netlib.org/f2c/libf2c.zip"
    sha256 "ca404070e9ce0a9aaa6a71fc7d5489d014ade952c5d6de7efb88de8e24f2e8e0"
  end

  resource "manual" do
    url "http://www.netlib.org/f2c/f2c.pdf"
    sha256 "816cdbfd20ce3695be0eb976648714b6fe496785bb8026c6b8911712764d57c7"
  end

  def install
    cp 'makefile.u', 'makefile'
    system "make"
    bin.install 'f2c'
    man1.install "f2c.1t" => "f2c.1"
    resource("lib").stage do
      cp 'makefile.u', 'makefile'
      make "f2c.h"
      system "make"
      include.install("f2c.h")
      lib.install("libf2c.a")
    end
    resource("manual").stage do
      doc.install 'f2c.pdf'
    end
  end

end
