class Objconv < Formula
  desc "Object file converter"
  homepage "http://www.agner.org/optimize/#objconv"
  url "http://www.agner.org/optimize/objconv.zip"
  version "2018-Jan-29"
  sha256 "f2c0c4cd6ff227e76ffed5796953cd9ae9eb228847ca9a14dba6392c573bb7a4"

  def install
    system "unzip", "source.zip", "-d", "source"
    cd "source" do
      system "bash", "build.sh"
      bin.install 'objconv'
    end
    doc.install 'objconv-instructions.pdf'
  end

end
