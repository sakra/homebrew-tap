require 'formula'

class Stlsoft < Formula
  homepage 'http://www.stlsoft.org'
  url 'http://downloads.sourceforge.net/project/stlsoft/STLSoft%201.9/1.9.121/stlsoft-1.9.121-hdrs.zip'
  version '1.9.121'
  sha1 'cafc353de6e8c9da832a6adaa3f1a8f5ed963235'

  depends_on 'dos2unix' => :build

  def install
    system "/usr/bin/find . -type f -exec dos2unix --keepdate '{}' ';'"
    # put all includes into a directory of their own
    (include + "stlsoft").install Dir['include/*']
  end

  def test
    system "true"
  end
end
