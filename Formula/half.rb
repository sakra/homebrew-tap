class Half < Formula
  desc "Floating-point library for half-precision floats"
  homepage "http://half.sourceforge.net/"
  url "https://sourceforge.net/projects/half/files/half/2.1.0/half-2.1.0.zip"
  sha256 "ad1788afe0300fa2b02b0d1df128d857f021f92ccf7c8bddd07812685fa07a25"
  license "MIT"

  depends_on "dos2unix" => :build

  def install
    system '/usr/bin/find . -type f -exec dos2unix --keepdate "{}" ";"'
    include.install "include/half.hpp"
    doc.install "README.txt"
  end
end
