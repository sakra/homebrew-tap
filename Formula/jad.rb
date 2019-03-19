require 'formula'

class JadDownloadStrategy < CurlDownloadStrategy
  def stage
    # the JAD tarball contains odd parent directory references, which unzip does not handle by default
    # -j -d forces all files to be extracted in the directory 'JAD'
    safe_system '/usr/bin/unzip', '-j', '-d', 'JAD', cached_location
    chdir
  end
end

class Jad < Formula
  homepage 'http://www.varaneckas.com/jad/'
  url 'http://www.varaneckas.com/jad/jad158g.mac.intel.zip', :using  => JadDownloadStrategy
  sha256 '8e9e4ea6c4177acce6d27325a036f10a72c170ed60e48c37c3483335319d07b9'
  version '1.5.8g'

  def install
    bin.install 'jad'
    man1.install 'jad.1'
    doc.install 'Readme.txt'
  end

end
