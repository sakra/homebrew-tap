class Objconv < Formula
  desc "Object file converter"
  homepage "http://www.agner.org/optimize/#objconv"
  url "http://www.agner.org/optimize/objconv.zip"
  version "2018-10-07"
  sha256 "dab11f4c63ef06ebfd5038a5e8d42e336d5aff11c6143bad252e84b953a3e672"

  def install
    system "unzip", "source.zip", "-d", "source"
    cd "source" do
      system "bash", "build.sh"
      bin.install 'objconv'
    end
    doc.install 'objconv-instructions.pdf'
  end

end
