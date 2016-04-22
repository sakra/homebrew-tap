require 'formula'

class Stlsoft < Formula
  homepage 'http://www.stlsoft.org'
  url 'http://downloads.sourceforge.net/project/stlsoft/STLSoft%201.9/1.9.124/stlsoft-1.9.124-hdrs.zip'
  version '1.9.124'
  sha1 'e580bcbf6d5530f6587038a959ee96ae820d7eda'

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
